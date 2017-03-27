# LEMON.JS - LALR(1) Parser Generator for JavaScript

Lemon.JS is an LALR(1) parser generator for JavaScript based on Lemon parser generator for C.

## Parser Code Base

Files `lemon.c`, `lempar.c`, `lemon.html` are extracted from SQLite v3.17.0. Original parser generator code is slightly fixed to produce JavaScript compatible statements. Parser template translated from C to JavaScript. Source comments mostly not touched to keep it easy diff against original file.

Both original C version and patched JS version are included for side by side comparison for reference.

## Special Directives

See lemon.html for additional documentation.

- %name - Set parser class name (default is "Parse")
- %include - Include code in the beginning of file (usefull for imports)
- %code - Include code in the end of file (usefull for exports or main code)
- %token_destructor - Define code which will be executed on token destruction.
- %default_destructor
- %token_prefix - Define token name prefix.
- %syntax_error - Define custom error handler for syntax erorrs.
- %parse_accept - Define handler for all accepted tokens.
- %parse_failure - Define handler for parse errors.
- %stack_overflow - Define handler for stack overflow.
- %extra_argument - **NOT SUPPORTED**
- %token_type - **NOT SUPPORTED**
- %default_type - **NOT SUPPORTED**
- %stack_size - Set default stack size.
- %start_symbol
- %left - Set left associative tokens.
- %right - Set right associative tokens.
- %nonassoc - Set non associative tokens.
- %destructor - Define custom parser destructor.
- %type - **NOT SUPPORTED**
- %fallback - Define fallback logic for tokens.
- %wildcard - Define WILDCARD token.
- %token_class - **NOT SUPPORTED**

Notes:

- some expressions, for example, regular expression `/\*/` could break lemon parser in `%code` or `%include` sections.
- the best place to put something like `module.exports = ParserName;` or `export default ParserName;` is in `%code` section.

## TODO

- add some tests for different options
- document variables
- YYNOERRORRECOVERY ?
- YYERRORSYMBOL ?
- rename methods, variables, get rid of YY prefixes?
- enable asserts, could be usefull for testing

## Alternative Lexers

- https://github.com/tantaman/lexed.js
- https://github.com/aaditmshah/lexer
- https://github.com/YuhangGe/jslex

## Alternative Parsers

- https://github.com/sormy/flex-js
- http://jscc.brobston.com
- http://zaach.github.io/jison/
- https://pegjs.org
