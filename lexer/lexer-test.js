var Lexer = require('./lexer');

var lexer = new Lexer();

lexer.addRule(/\d+/, function (value) {
  return { major: "INTEGER", minor: parseInt(value, 10) };
});
lexer.addRule('+', function (value) {
  return { major: "PLUS", minor: null };
});
lexer.addRule('-', function (value) {
  return { major: "MINUS", minor: null };
});
lexer.addRule('/', function (value) {
  return { major: "DIVIDE", minor: null };
});
lexer.addRule('*', function (value) {
  return { major: "TIMES", minor: null };
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
    console.log(token);
  }
});
