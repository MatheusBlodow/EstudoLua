function validate(value)
	if value > 10 then
		return true, nil
	else
		return false, "invalid number"
	end
end

valid, error_message = validate(7)

if valid then
	print("OK!")
else
	print(error_message)
end