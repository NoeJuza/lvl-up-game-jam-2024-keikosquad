extends Node

var value = 0
signal on_change


func _set_value(new_value):
	value = new_value
	emit_signal("on_change", value)


func _get_value():
	return value


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
