%name Parser

%token_prefix TOKEN_

%left PLUS MINUS.
%left DIVIDE TIMES.

%include {
  // include something
}

%code {
  var Lexer = require('../lexer/lexer');

  var parser = new Parser();

  parser.setTraceCallback(function (value) {
    process.stdout.write(value);
  }, '> ');

  var lexer = new Lexer();

  lexer.addRule(/\d+/, function (value) {
    return { major: parser.TOKEN_INTEGER, minor: parseInt(value, 10) };
  });
  lexer.addRule('+', function (value) {
    return { major: parser.TOKEN_PLUS, minor: null };
  });
  lexer.addRule('-', function (value) {
    return { major: parser.TOKEN_MINUS, minor: null };
  });
  lexer.addRule('/', function (value) {
    return { major: parser.TOKEN_DIVIDE, minor: null };
  });
  lexer.addRule('*', function (value) {
    return { major: parser.TOKEN_TIMES, minor: null };
  });
  lexer.addRule(/\s+/, function () {});

  var data = '';

  process.stdin.on('data', function (chunk) {
    data += chunk;
  });

  process.stdin.on('end', function () {
    var token;

    lexer.setInput(data);

    while (token = lexer.lex()) {
      parser.parse(token.major, token.minor);
    }

    parser.parse();
  });
}

%syntax_error {
  console.log("Syntax error");
}

program ::= expr(A). { console.log("Result=" + A); }
expr(A) ::= expr(B) MINUS expr(C). { A = B - C; }
expr(A) ::= expr(B) PLUS expr(C). { A = B + C; }
expr(A) ::= expr(B) TIMES expr(C). { A = B * C; }
expr(A) ::= expr(B) DIVIDE expr(C). {
  if (C != 0) {
    A = B / C;
  } else {
    throw new Error("Divide by zero");
  }
}
expr(A) ::= INTEGER(B). { A = B; }
