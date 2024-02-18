extends Node

signal stock_amount_changed()
signal item_selected_buyzone(index)
var materials = {"egg":{"name":"egg","texture": ImageTexture.create_from_image(Image.load_from_file("res://assets/ressources/eggs.png"))}, "wood":{"name":"wood","texture": ImageTexture.create_from_image(Image.load_from_file("res://assets/ressources/log.png"))}}
var components = {"tadpole":{"name":"tadpole","texture": ImageTexture.create_from_image(Image.load_from_file("res://assets/ressources/tadpole.png"))}, "plank":{"name":"plank","texture": ImageTexture.create_from_image(Image.load_from_file("res://assets/ressources/planks.png"))}}
var forges = {"egg":{"texture":ImageTexture.create_from_image(Image.load_from_file("res://assets/machine/machine-egg_to_tadp.png"))}, "wood":{"texture":ImageTexture.create_from_image(Image.load_from_file("res://assets/machine/machine-log_to_planck.png"))}}
var scrappers = {"tadpole":
					{"texture":ImageTexture.create_from_image(Image.load_from_file("res://assets/machine/machine-tadp_to_egg.png"))},
				"plank":
					{"texture":ImageTexture.create_from_image(Image.load_from_file("res://assets/machine/machine-planck_to_wood.png"))}
				}
var constructions = [{"name": "big frog", "costs": [2,0]},{"name": "frog on a stool", "costs": [1,1]}]

var stock_dict = {"tadpole": 0, "plank": 0} 
# Add amount
func add_stock_amount(name, value):
	stock_dict[name] += value
	emit_signal("stock_amount_changed")
	
# Getter pour la valeur "amount" dans le tableau stock_array
func get_stock_amount(name):
	return stock_dict[name]
	
# Getter amount
func emit_item_selected_buyzone(index):
	emit_signal("item_selected_buyzone", index)


