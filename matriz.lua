matriz = {
	{"a","b","c"},
	{"d","e","f"}
}

for index,line in pairs(matriz) do
	print("line ".. index .. ":")
	for _, column in pairs(line) do
		print(column)
	end
end

