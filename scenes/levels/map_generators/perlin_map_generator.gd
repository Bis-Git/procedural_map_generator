extends Node2D

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var width = 50
var height = 50


func _ready():
	randomize()
	moisture.seed = randf() * 100
	temperature.seed = randf() * 100
	moisture.noise_type = FastNoiseLite.TYPE_PERLIN
	temperature.noise_type = FastNoiseLite.TYPE_PERLIN
	generate()



func generate():
	#var tiles = []
	
	for x in range(-width, width):
		for y in range(-height, height):
			var rand_moisture: int = floor(abs(moisture.get_noise_2d(x, y) * 20))
			var rand_temperature: int = floor(abs(temperature.get_noise_2d(x, y) * 20))
			
			#Barf code
			if rand_moisture > 6:
				rand_moisture -= 6
				rand_temperature += 1
				
			if rand_temperature > 6:
				if rand_moisture > 5:
					rand_moisture -= 5
					rand_temperature += 1
					
#			if rand_moisture > 6:
#				tiles.append([rand_moisture, rand_temperature])
			$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(rand_moisture, rand_temperature))
			
	#print("TILES: ", tiles)
