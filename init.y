%{
#include<stdio.h>
%}


%token PYSTART CSTART END CODE EPS

%%

start: PYSTART start END start
	   | CSTART start END start
	   | CODE start
	   | EPS
	   ;
EPS: ;
%%

int main(){
	printf("Enter code");
	yyparse();
	printf("Valid syntax");
	return 0;
}

int yyerror(){
	printf("Invalid syntax");
	exit(0);
}
