extends Node

signal material_amount_changed(name, value)

var material_array = [
	{"name": "egg", "amount": 2},
	{"name": "wood", "amount": 0}
]

# Setter amount
func set_material_amount(name, value):
	material_array[material_array.find(name)]["amount"] += value
	emit_signal("material_amount_changed", name, value)

# Add amount (TO KEEP)
func add_material_amount(name, value):
	material_array[material_array.find(name)]["amount"] += value
	emit_signal("material_amount_changed", name, value)
	
# Getter amount
func get_material_amount(name):
	return material_array[material_array.find(name)]["amount"]

