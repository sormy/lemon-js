%token_type {int}

%left PLUS MINUS.
%left DIVIDE TIMES.

%include {
  #include <stdio.h>
  #include <stdlib.h>
  #include <assert.h>
  #include "calculator-c.h"
}

%code {
  int main()
  {
    void* pParser = ParseAlloc(malloc);
    ParseTrace(stderr, "> ");
    Parse(pParser, INTEGER, 1);
    Parse(pParser, PLUS, 0);
    Parse(pParser, INTEGER, 2);
    Parse(pParser, TIMES, 0);
    Parse(pParser, INTEGER, 10);
    Parse(pParser, DIVIDE, 0);
    Parse(pParser, INTEGER, 2);
    Parse(pParser, 0, 0);
    ParseFree(pParser, free);
  }
}

%syntax_error {
  fprintf(stderr, "Syntax error\n");
}

program ::= expr(A). { printf("Result=%d\n", A); }
expr(A) ::= expr(B) MINUS expr(C). { A = B - C; }
expr(A) ::= expr(B) PLUS expr(C). { A = B + C; }
expr(A) ::= expr(B) TIMES  expr(C). { A = B * C; }
expr(A) ::= expr(B) DIVIDE expr(C). {
  if (C != 0) {
    A = B / C;
  } else {
    fprintf(stderr, "Divide by zero\n");
  }
}
expr(A) ::= INTEGER(B). { A = B; }
