extends Node2D

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 128
var height = 128

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()

func _process(delta):
	generate_chunk($"../Player".position)	
	
func generate_chunk(position):
	#convert position (world coordinates) to tile coordinates
	var tile_pos = $TileMap.local_to_map(position)
	for x in range(width):
		for y in range(height):
			#(width|height)/2 is for fixing camera center
			#multiplying by 10 cuz noise returns a value between -1 and 1
			var moist = moisture.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y) * 10
			var temp = temperature.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y) * 10
			var alt = altitude.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y) * 10
			
			#atlas is being treated as a graph where y = temperature & x = moisture
			
			if(alt < 2):
				$TileMap.set_cell(0, Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y), 0, Vector2(3, round((temp + 10) / 5)))
			else:
				$TileMap.set_cell(0, Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y), 0, Vector2(round((moist + 10) / 5), round((temp + 10) / 5)))
