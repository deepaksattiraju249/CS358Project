%{
#include "init.tab.h"
%}
%%
#%Py {return PYSTART;}
#%C {return CSTART;}
#% {return END;}
. {return CODE;};
%%

int yywrap(){
}

