extends TileMap

var _tiles_array   = []
var _selected_tile = 0
var tile_map_id    = 5
var _previous_hovered_cell = Vector2i(0, 0)


#@onready var tileSelectMat: ShaderMaterial = load("res://placing/TileSelectMaterial.material")


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
#func _process(delta):
#	pass


#func _draw():
#	pass


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var clicked_cell = local_to_map(event.position)
		var tile         = _tiles_array[_selected_tile]
		var properties   = tile["properties"]

		var cpt = 0
		for prop in properties:
			var position = Vector2i(clicked_cell.x - cpt, clicked_cell.y - cpt)
			var tile_id  = prop["tile_id"]

			set_cell(2, position, tile_map_id, tile_id)
			cpt += 1

	if event is InputEventMouseMotion:
		var hovered_cell = local_to_map(event.position)

		var hover_tile = Vector2i(1, 1)
		set_cell(1, hovered_cell, tile_map_id, hover_tile)

		if _previous_hovered_cell != hovered_cell:
			set_cell(1, _previous_hovered_cell, -1, Vector2i(0, 0))
			_previous_hovered_cell = hovered_cell


func _on_item_list_item_selected(index):
	_selected_tile = index


func _on_item_list_ready():
	var item_list = $"../ItemList"
	if(item_list != null):
		for tile in _tiles_array:
			item_list.add_item(tile["name"])
	

