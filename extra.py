s = open("sym.txt","r")
r = open("1.rb", "w")
st = ""
for line in s:
	l = line.split(":")
	if( l[0] == "int" or l[0] == "float"):
		st = st + l[1] + "=" + l[2] + "\n"
	elif( l[0] == "str" ):
		st = st + l[1] + '="' + l[2] + '"\n'
r.write(st)
s.close()
r.close()