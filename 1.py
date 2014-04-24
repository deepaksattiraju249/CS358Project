f = open('sym.txt', 'r')
for line in f:
	line = line.split(':')
	if line[0] == 'int':
		locals()[line[1]] = int(line[2])
	elif line[0] == 'float':
		locals()[line[1]] = float(line[2])
	elif line[0] == 'str':
		locals()[line[1]] = str(line[2])

a = 0
print "This is from Python 2nd time", a

f = open('sym.txt','w')
var_dic = locals().copy()
for var in var_dic:
	val = str(type(var_dic[var])).split("'")[1] +  ':' + var + ':' + str(var_dic[var])+':\n'
	f.write(val)
f.close()