extends WorldObject
class_name Construction
var hps = 100
var has_already_lost_half = false
signal hps_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.value = hps

func heal():
	hps += 25
	hps_changed.emit()
	
func damage(amount):
	if hps > 0:
		hps -= amount
		hps_changed.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hps_changed():
	$ProgressBar.value = hps
	if hps <= 50 and not has_already_lost_half:
		has_already_lost_half = true
		create_component_in_front()
	if hps <= 0:
		create_component_in_front()
		queue_free()
func create_component_in_front():
	var component = load("res://worldobjects/battle/component/component.tscn")
	var instance = component.instantiate()
	get_parent().add_child(instance)
	instance.position = Vector2(position.x, position.y + 100)
