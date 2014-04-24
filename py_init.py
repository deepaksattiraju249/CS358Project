f = open('sym.txt', 'r')
for line in f:
    line = line.split(':')
    if line[0] == "int":
        locals()[line[1]] = int(line[2])
    elif line[0] == "float":
        locals()[line[1]] = float(line[2])
    elif line[0] == "str":
        locals()[line[1]] = str(line[2])
        
