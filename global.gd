extends Node

signal stock_amount_changed()
signal item_selected_buyzone(index)

var stock_array = [
	{"name": "frog", "amount": 2},
	{"name": "plank", "amount": 0}
]

# Add amount
func add_stock_amount(name, value):
	stock_array[stock_array.find(name)]["amount"] += value
	emit_signal("stock_amount_changed")
	
# Getter pour la valeur "amount" dans le tableau stock_array
func get_stock_amount(name):
	return stock_array[stock_array.find(name)]["amount"]
	
# Getter amount
func emit_item_selected_buyzone(index):
	emit_signal("item_selected_buyzone", index)


