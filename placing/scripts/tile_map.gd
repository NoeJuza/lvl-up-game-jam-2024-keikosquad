extends TileMap

var _tiles_array = []
var _selected_tile = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# campfire
	_tiles_array.append({
		"name": "Campfire",
		"properties": [
			{"name": "base", "tile_id": Vector2i(6, 9)},
			{"name": "top", "tile_id": Vector2i(6, 8)}
		]
	})


	# rock
	_tiles_array.append({
		"name": "Rock",
		"properties": [
			{"name": "base", "tile_id": Vector2i(4, 14)},
			{"name": "center", "tile_id": Vector2i(4, 13)},
			{"name": "top", "tile_id": Vector2i(4, 12)}
		]
	})
	
		

	print("MAIS C'EST PAS ABORDABLE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	pass


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var clicked_cell = local_to_map(event.position)
		var tile = _tiles_array[_selected_tile]
		var properties = tile["properties"]
		
		var cpt = 0
		for prop in properties:
			var position = Vector2i(clicked_cell.x - cpt, clicked_cell.y - cpt)
			var tile_id = prop["tile_id"]
			
			set_cell(1, position, 2, tile_id)
			cpt += 1



	#if event is InputEventMouseMotion:
		#var hovered_cell = local_to_map(event.position)
		# create a new black tile
		#var tile = TileMap.new()
		#tile.tile_set = tile_set
		#tile.cell_size = 64
		#tile.set_cell(0, hovered_cell, 1, Vector2i(4, 14))
		#add_child(tile)


func _on_item_list_item_selected(index):
	_selected_tile = index


func _on_item_list_ready():
	var item_list = $"../Control/ItemList"
	for tile in _tiles_array:
		item_list.add_item(tile["name"])
