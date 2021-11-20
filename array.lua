idades = { 20, 42, 54, 57, 11, 30, 18 }

--for i = 1, #idades do 
--    print(i)
--    print(idades[i])
--end

table.insert(idades, 12)

for i, idade in ipairs(idades) do 
    print(i)
    print(idade)
end