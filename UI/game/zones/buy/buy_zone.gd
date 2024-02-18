extends TileMap

var _sprites_array: Array[Variant]   = []
var _selected_tile: int              = 0
var _tile_map_id: int                = 5
var _grey_tile_map_id: int           = 6
var _previous_hovered_cell: Vector2i = Vector2i(0, 0)
var _exclude_tiles: Array[Vector2i]  = []
var _item_selected_in_list: bool     = false
var _was_cleared: bool               = false
var _placed_tiles: Array[Vector2i]   = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# Blacklisted tiles
	_exclude_tiles.append(Vector2i(0, 2))
	_exclude_tiles.append(Vector2i(1, 2))
	_exclude_tiles.append(Vector2i(2, 2))
	_exclude_tiles.append(Vector2i(1, 1))
	_exclude_tiles.append(Vector2i(2, 1))
	_exclude_tiles.append(Vector2i(3, 1))

	global.item_selected_buyzone.connect(_on_item_list_item_selected)

	# campfire
	_sprites_array.append({
		"name": "Frog on a stool",
		"sprite": $"../Buy/frog on a stool",
	})

	# rock
	_sprites_array.append({
		"name": "Big frog",
		"sprite": $"../Buy/big frog",
	})

	print("MAIS C'EST PAS ABORDABLE")


func _unhandled_input(event):
	if !_item_selected_in_list:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var clicked_cell: Vector2i = local_to_map(event.position)
		var clicked_tile: Vector2i = get_cell_atlas_coords(0, clicked_cell)

		if !_is_tile_in_blacklist(clicked_tile):
			var sprite = _sprites_array[_selected_tile]["sprite"]
			#duplicate the sprite

			var new_sprite = sprite.duplicate()
			if(sprite != null and _placed_tiles.find(clicked_cell) == -1):
				new_sprite.position = event.position
				add_child(new_sprite)
				_placed_tiles.append(clicked_cell)
				_clear_selected_tile()

	if event is InputEventMouseMotion:
		var hovered_cell: Vector2i = local_to_map(event.position)
		var hover_tile: Vector2i   = get_cell_atlas_coords(0, hovered_cell)

		if !_is_tile_in_blacklist(hover_tile):
			set_cell(1, hovered_cell, _grey_tile_map_id, hover_tile)

		if _previous_hovered_cell != hovered_cell:
			set_cell(1, _previous_hovered_cell, -1, Vector2i(0, 0))
			_previous_hovered_cell = hovered_cell
			_was_cleared = false

		if _was_cleared == true and _previous_hovered_cell == hovered_cell:
			_clear_selected_tile()


func _clear_selected_tile():
	set_cell(1, _previous_hovered_cell, -1, Vector2i(0, 0))
	_was_cleared = true
	# deselect all other items
	$"../Buy/ItemList".deselect_all()
	_item_selected_in_list = false


func _is_tile_in_blacklist(tile: Vector2i) -> bool:
	return _exclude_tiles.find(tile) != -1


func _on_item_list_item_selected(index):
	_selected_tile = index
	_item_selected_in_list = true


func _on_ui_buy_ready():
	var item_list = $"../Buy/ItemList"
	print(item_list)
	if(item_list != null):
		for sprite in _sprites_array:
			item_list.add_item(sprite["name"])
