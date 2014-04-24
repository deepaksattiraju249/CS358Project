%{
#include<stdio.h>
#include<stdlib.h>
int flag = 0;
int hec=0 , shec = 0;
%}
%%
\n {hec++ ;}
[' '] {shec++;}
['/'] { return;}
.;
%%

yywrap(){
}

void main()
{
	yylex();
	printf("count he : %d \n count she: %d",hec + shec,shec);
}

