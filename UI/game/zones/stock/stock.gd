extends Node

var item_list: ItemList = null

# Called when the node enters the scene tree for the first time.
func _ready():
	item_list = $"../ItemList"
	# https://www.nightquestgames.com/godot-4-basics-how-to-use-signals-for-node-communication-with-examples/
	global.stock_amount_changed.connect(_on_stock_amount_changed)

func _on_item_list_ready():
	print("list_ready")
	for i in range(len(global.stock_array)):
		item_list.add_item(" ")

	global.add_stock_amount("plank", 0) # initial update

func _on_button_pressed():
	global.add_stock_amount("plank", 5)

func _on_stock_amount_changed():
	print("on_stock")
	# update display
	for i in range(item_list.get_item_count()):
		var stock = global.stock_array[i]
		item_list.set_item_text(i, str(stock["name"]) + " : " + str(stock["amount"]))

