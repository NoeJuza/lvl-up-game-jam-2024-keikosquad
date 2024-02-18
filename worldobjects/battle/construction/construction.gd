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
	hps += 50
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
		var component = load("res://worldobjects/battle/component/component.tscn")
		var instance = component.instantiate()
		var random = RandomNumberGenerator.new()
		var rdm = random.randi_range(0,1)
		instance.component_name = "tadpole" if rdm else "plank"
		instance.collider_radius = 40
		get_parent().add_child(instance)
		instance.position = Vector2(position.x, position.y + 100)
	if hps > 50 and not can_spawn_component:
		can_spawn_component = true
	if hps <= 0:
		var material = load("res://worldobjects/battle/material/material.tscn")
		var instance = material.instantiate()
		var random = RandomNumberGenerator.new()
		var rdm = random.randi_range(0,1)
		instance.material_name = "egg" if rdm else "wood"
		instance.collider_radius = 40
		get_parent().add_child(instance)
		instance.position = Vector2(position.x, position.y + 100)
		queue_free()
	


func _on_static_body_2d_2_input_event(viewport, event, shape_idx):
	print("has input evented")
	if Input.is_action_just_released("tear_down"):
		hps = 0
		hps_changed.emit()
