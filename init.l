%{
#include "init.tab.h"
extern yylval;
%}
%%
#%Py {return PYSTART;}
#%Rb {return RSTART;}
%# {return END;}
. {yylval = *yytext;return CODE;}
\n {yylval = (int)yytext;return NL;}
\n\n {return;};
%%

int yywrap(){
}

