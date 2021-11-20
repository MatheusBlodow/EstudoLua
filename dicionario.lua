copas = {
	[10] = "01",
	[29] = "02",
	[52] = "03",
	ano = 2002,
	jogadores = {"Cafu", "Ronaldo"},
	imprime = function(self)
		for k,v in ipairs(self.jogadores) do
			print(k,v)
		end
	end
	}

copas.capitao = "cafu"
table.insert(copas.jogadores, "Rivaldo")
table.remove(copas.jogadores, 2)

for k,v in ipairs(copas.jogadores) do
	print(k,v)
end

copas.imprime(copas)
copas:imprime()