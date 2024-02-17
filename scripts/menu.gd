extends ItemList




func _ready():
	# Add items to the list

	print("test")
	
func _on_item_selected(index):
	# Get the text of the selected item
	var selected_item_text = get_item_text(index)
	
	# Print the selected item text
	print("Selected item:", selected_item_text)


	# Execute your desired functionality here based on the selected item
	# For example, you could open a dialog, load a specific scene, etc.
	# Example: load_scene(selected_item_text)
	
	# var tile_set = get_tileset()
	# tile_set.set_cell(0, 0, 0)
	

