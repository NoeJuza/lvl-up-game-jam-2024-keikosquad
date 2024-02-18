extends ItemList

func _on_item_selected(index):
	global.emit_item_selected_buyzone(index)
