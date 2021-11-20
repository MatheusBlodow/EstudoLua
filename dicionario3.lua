products = {
	{
		name = "apple",
		price = 2.48,
		units = 5},
	{
		name = "orange",
		price = 1.79,
		units = 10}}
sum = 0.0

for _, product in pairs(products) do
	total = product.price * product.units
	
	sum = sum + total
	
	print(
			product.name .. " R$ " ..
			product.price .. " x " ..
			product.units .. " = " ..
			"R$" .. total)
end

print ("\n Total = R$ " .. sum)