# LEMON.JS - LALR(1) Parser Generator for JavaScript

Lemon.JS is an LALR(1) parser generator for JavaScript based on Lemon parser generator for C.

## Parser Code Base

Files lemon.c, lempar.c, lemon.html are extracted from SQLite v3.17.0.
Original parser generator code is slightly fixed to produce JavaScript compatible statements.
Parser template translated from C to JavaScript.
Source comments mostly not touched to keep it easy diff against original file.

Both original C version and patched JS version are included side by side for reference.

## Special Directives

See lemon.html for additional documentation.

%name
%include
%code
%token_destructor
%default_destructor
%token_prefix
%syntax_error
%parse_accept
%parse_failure
%stack_overflow
%extra_argument
%token_type
%default_type
%stack_size
%start_symbol
%left
%right
%nonassoc
%destructor
%type
%fallback
%wildcard
%token_class

Notes:

- some expressions, for example, regular expression `/\*/` could break lemon parser in %code or %include sections.
- the best place to put something like `module.exports = ParserName;` or `export default ParserName;` is in %code.

## TODO

- document variables
- YYNOERRORRECOVERY ?
- YYERRORSYMBOL ?
- rename methods, variables?
- recover asserts

## Alternative Lexers

- https://github.com/tantaman/lexed.js
- https://github.com/aaditmshah/lexer
- https://github.com/YuhangGe/jslex

## Alternative Parsers

- http://jscc.brobston.com
- http://zaach.github.io/jison/
- https://pegjs.org
