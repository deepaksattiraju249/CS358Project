a=10
number_of_variables=7
__file__="1.py"
counter=3
variables_values="int"
__name__="__main__"

puts "\nFrom Ruby\n"
a = a + 12
puts "#{a}"
number_of_variables = local_variables.length
counter = 0
variables_values = ""
while counter < number_of_variables	
	if eval(local_variables[counter]).instance_of? Fixnum
		variables_values +=  "int:"+local_variables[counter]+":"+eval(local_variables[counter]).to_s+":\n"
	elsif eval(local_variables[counter]).instance_of? String
		variables_values += "str:"+local_variables[counter]+":"+eval(local_variables[counter]).to_s+":\n"
	elsif eval(local_variables[counter]).instance_of? Float
		variables_values += "float:"+local_variables[counter]+":"+eval(local_variables[counter]).to_s+":\n"
	end
	counter = counter + 1
end
aFile = File.new("sym.txt", "w")
if aFile
	aFile.syswrite(variables_values)
	aFile.close
end
