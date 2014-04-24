f = open("sym.txt","w")
var_dic = locals().copy()
for var in var_dic:
    val = str(type(var_dic[var])).split("'")[1] +  ":" + var + ":" + str(var_dic[var])+":\n"
    f.write(val)
f.close()
