function Lexer() {
  this.index = 0;
  this.rules = [];
  this.input = '';
}

Lexer.prototype.addRule = function (expression, handler) {
  if (typeof expression === 'string') {
    expression = new RegExp(this.escapeRE(expression), 'y');
  }
  if (expression instanceof RegExp && !expression.sticky) {
    expression = new RegExp(expression.source, expression.flags + 'y');
  }
  this.rules.push([ expression, handler ]);
}

Lexer.prototype.setInput = function (input) {
  this.input = input;
}

Lexer.prototype.escapeRE = function (s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

Lexer.prototype.execRE = function (re) {
  re.lastIndex = this.index;
  var result = re.exec(this.input);
  return result ? result[0] : undefined;
}

Lexer.prototype.raiseSyntaxError = function () {
  throw new Error('Syntax error');
}

Lexer.prototype.lex = function () {
  if (this.index >= this.input.length) {
    return;
  }

  var token;
  var matched;

  do {
    matched = false;

    for (var index in this.rules) {
      var rule = this.rules[index];

      var expression = rule[0];
      var handler = rule[1];

      var value = this.execRE(expression);

      if (value !== undefined) {
        token = handler(value);
        matched = true;
        this.index += value.length;
        break;
      }
    }
    // undefined token with match is a sign that we need to search next token
  } while (matched && token === undefined && this.index < this.input.length);

  if (!matched) {
    this.raiseSyntaxError();
  }

  return token;
}

module.exports = Lexer;
