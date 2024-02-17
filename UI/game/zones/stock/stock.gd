extends Node


# https://www.nightquestgames.com/godot-4-basics-how-to-use-signals-for-node-communication-with-examples/
# Called when the node enters the scene tree for the first time.
func _ready():
	global.material_amount_changed.connect(_on_material_amount_changed)

func _on_item_list_ready():
	print("list_ready")
	var item_list = $"../Ressources/Buy/ItemList"
	for material in global.material_array:
		item_list.add_item(str(material["name"]) + " : " + str(material["amount"]))
	

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	global.set_material_amount("wood", 5)
	print(global.material_array)

func _on_material_amount_changed(name, value):
	print("on_material")
	var item_list = $"../Ressources/Buy/ItemList"
	item_list.clear()
	for material in global.material_array:
		item_list.add_item(str(material["name"]) + " : " + str(material["amount"]))
