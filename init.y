%{
#include<string.h>
char *strrev(char *str)
{
      char *p1, *p2;
      if (! str || ! *str)
            return str;
      for (p1 = str, p2 = str + strlen(str) - 1; p2 > p1; ++p1, --p2)
      {
            *p1 ^= *p2;
            *p2 ^= *p1;
            *p1 ^= *p2;
      }
      return str;
}

#include<stdio.h>
#include<unistd.h>

FILE * ofp;
FILE * ofr;
char fcode[100];
int r_i;
int py_i;

char py_init[] = "f = open('sym.txt', 'r')\nfor line in f:\n\tline = line.split(':')\n\tif line[0] == 'int':\n\t\tlocals()[line[1]] = int(line[2])\n\telif line[0] == 'float':\n\t\tlocals()[line[1]] = float(line[2])\n\telif line[0] == 'str':\n\t\tlocals()[line[1]] = str(line[2])\n";

char py_end[] = "\nf = open('sym.txt','w')\nvar_dic = locals().copy()\nfor var in var_dic:\n\tval = str(type(var_dic[var])).split(\"'\")[1] +  ':' + var + ':' + str(var_dic[var])+':\\n'\n\tf.write(val)\nf.close()";

char rb_end[] = "number_of_variables = local_variables.length\ncounter = 0\nvariables_values = \"\"\nwhile counter < number_of_variables	\n\tif eval(local_variables[counter]).instance_of? Fixnum\n\t\tvariables_values +=  \"int:\"+local_variables[counter]+\":\"+eval(local_variables[counter]).to_s+\":\\n\"\n\telsif eval(local_variables[counter]).instance_of? String\n\t\tvariables_values += \"str:\"+local_variables[counter]+\":\"+eval(local_variables[counter]).to_s+\":\\n\"\n\telsif eval(local_variables[counter]).instance_of? Float\n\t\tvariables_values += \"float:\"+local_variables[counter]+\":\"+eval(local_variables[counter]).to_s+\":\\n\"\n\tend\n\tcounter = counter + 1\nend\naFile = File.new(\"sym.txt\", \"w\")\nif aFile\n\taFile.syswrite(variables_values)\n\taFile.close\nend";
 
%}


%token PYSTART RSTART END CODE NL

%%

start: start py
	| start rb
	| EPS
    | start NL
	;
py:	PYSTART pcode END
					{
					ofp = fopen("1.py","w");
					char *code = strrev(fcode);
				    fprintf(ofp,py_init); 
				    fprintf(ofp, code); 
				    fprintf(ofp,py_end); 
				    fclose(ofp); 
				    py_i = 0; 
				    memset(fcode,'\0',100);
				    int i = fork(); 
				    if(i == 0)
				    {
				    	execl("/usr/bin/python", "python", "1.py", (char *)NULL);
				    }
				    else
				    {
				    	wait();
				    }
				    }


rb:	RSTART rcode END{
					int k = fork(); 
					if (k == 0)
					{
						execl("/usr/bin/python", "python", "extra.py", (char *)NULL);
					} 
					else
					{
						wait();
						printf("1"); ofr = fopen("1.rb","a"); 
						char *code = strrev(fcode); 
						fprintf(ofr, code); 
						fprintf(ofp,rb_end); 
						fclose(ofr);
						r_i = 0;
						memset(fcode,'\0',100);
						int i = fork(); 
						if(i==0)
						{						
							execl("/usr/bin/ruby", "ruby", "1.rb", (char *)NULL);
						}
					}
				};


pcode: CODE pcode{ fcode[py_i] = (char)$1; py_i++;}
	| NL pcode{fcode[py_i] = '\n';py_i++;}
	| EPS{}
	;


rcode: CODE rcode{ fcode[r_i] = (char)$1; r_i++;}
	| NL rcode{fcode[r_i] = '\n';r_i++;}
	| EPS{}
	;

EPS: ;
%%

int main(){
	
	py_i = 0;
	r_i = 0;
	printf("Enter code\n");
	yyparse();
	printf("Valid syntax");
	return 0;
}

int yyerror(){
	printf("Invalid syntax");
	exit(0);
}
