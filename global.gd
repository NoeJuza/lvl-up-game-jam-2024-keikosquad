extends Node

signal material_amount_changed(name, value)
signal item_selected_buyzone(index)

var material_array = [
	{"name": "egg", "amount": 2},
	{"name": "wood", "amount": 0}
]

# Setter pour la valeur "amount" dans le tableau material_array
func set_material_amount(name, value):
	material_array[material_array.find(name)]["amount"] += value
	emit_signal("material_amount_changed", name, value)
	print("emit")
	
func emit_item_selected_buyzone(index):
	emit_signal("item_selected_buyzone", index)
	

# Getter pour la valeur "amount" dans le tableau material_array
func get_material_amount(name):
	return material_array[material_array.find(name)]["amount"]

