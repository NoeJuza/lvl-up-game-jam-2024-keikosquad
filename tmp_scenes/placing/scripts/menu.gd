extends ItemList

func _on_item_selected(index):
	# Emit the signal with the index of the selected item
	global.emit_item_selected_buyzone(index)
