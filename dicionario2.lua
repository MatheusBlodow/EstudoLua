config = {
	screen = {
		width = 800,
		height = 600,
		color = { number = 16}
	},
	keyboard = {language = "pt-BR"}
	}

print (config["screen"].width)
print (config.screen.color.number)