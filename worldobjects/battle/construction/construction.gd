extends WorldObject
class_name Construction
@export var construction_name: String
var hps = 100
var can_spawn_component = true
signal hps_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.value = hps
	$StaticBody2D2/AnimatedSprite2D.play(construction_name)
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
	if hps <= 50 and can_spawn_component:
		can_spawn_component = false
		create_component_in_front()
	if hps > 50 and not can_spawn_component:
		can_spawn_component = true
	if hps <= 0:
		create_component_in_front()
		queue_free()
		
func create_component_in_front():
	var component = load("res://worldobjects/battle/component/component.tscn")
	var instance = component.instantiate()
	instance.component_name = "tadpole"
	instance.collider_radius = 40
	get_parent().add_child(instance)
	instance.position = Vector2(position.x, position.y + 100)
