extends Node

signal stock_amount_changed()
signal item_selected_buyzone(index)
signal remove_placed_tile(event)
signal enemies_killed_updated
var materials = {"egg":{"name":"egg","texture": load("res://assets/ressources/eggs.png")}, "wood":{"name":"wood","texture": load("res://assets/ressources/log.png")}}
var components = {"tadpole":{"name":"tadpole","texture": load("res://assets/ressources/tadpole.png")}, "plank":{"name":"plank","texture": load("res://assets/ressources/planks.png")}}
var forges = {"egg":{"texture":load("res://assets/machine/machine-egg_to_tadp.png")}, "wood":{"texture":load("res://assets/machine/machine-log_to_planck.png")}}
var scrappers = {"tadpole":
					{"texture":load("res://assets/machine/machine-tadp_to_egg.png")},
				"plank":
					{"texture":load("res://assets/machine/machine-planck_to_wood.png")}
				}

var constructions = [{"name": "big frog", "costs": {"tadpole": 2, "plank": 0}}, {"name": "frog on a stool", "costs": {"tadpole": 1, "plank": 1}}]

var stock_dict = {"tadpole": 0, "plank": 0}
var enemies_killed = 0
var frogs_placed = -2
func increment_enemies_killed():
	enemies_killed += 1
	emit_signal("enemies_killed_updated")
# Add amount
func add_stock_amount(name, value):
	stock_dict[name] += value
	emit_signal("stock_amount_changed")

# Remove amount
func remove_stock_amount(name, value):
	stock_dict[name] -= value
	emit_signal("stock_amount_changed")
	
# Getter pour la valeur "amount" dans le tableau stock_array
func get_stock_amount(name):
	return stock_dict[name]
	
# Getter amount
func emit_item_selected_buyzone(index):
	emit_signal("item_selected_buyzone", index)

func emit_remove_placed_tile(event):
	emit_signal("remove_placed_tile", event)

var wave = 1
