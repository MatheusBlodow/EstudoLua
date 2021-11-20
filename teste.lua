function teste()
	grade = 4
	
	if grade < 0 or grade > 10 then
		return "invalid grade"
	elseif grade >= 6 then
		return "pass"
	elseif grade >= 0 and grade < 6 then
		return "fail"
	end
end

function teste1()
	for number = 4, 1, -1 do 
		return number
	end
end

function teste3()
	number1 = 0
	continue = true

	while continue do
		number1 = number1 + 1
		if number1 > 5 then
			continue = false	
		end
		return number1
	end
end

function teste4()
	text = "hello woRlD"

	length = string.len(text)
	partial = string.sub(text, 7, 11)

	--print(string.lower(text))
	--print(string.upper(text))
	--print(partial)
	--print(#"hello")
	return partial
end

function teste5()
	encontrar = "Get a box of apples"

	result = string.gsub(encontrar, "apples", "oranges")

	return result
end


function teste6()
	email = "teste@gmail.com"

	at = string.find(email, "@")

	if at == nil then
		return "invalid email"
	else
		provider = string.sub(email, at+1, #email)
		return ("Provider: " .. provider)
	end
end

print(teste3())