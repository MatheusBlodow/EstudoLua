calculo = require("calculos/calculo")

--print(multiply(2,2))

command = arg[1]
a = arg[2]
b = arg[3]

if command == "+" then
	print(calculo.add(a, b))
elseif command == "-" then
	print(calculo.subtract(a, b))
elseif command == "." then
	print(calculo.multiply(a, b))
elseif command == "/" then
	print(calculo.divide(a, b))
else
	print("Unknown command: ")
end