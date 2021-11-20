exchange_rate = 5.42

dollars = {10.75, 25, 100}
reais = {}

for i, value in pairs(dollars) do
	new_value = value * exchange_rate
	table.insert(reais, new_value)
end

for i, _ in pairs(reais) do
	real = reais[i]
	dollar = dollars[i]
	print("$" .. dollar .. "=" .. real)
end