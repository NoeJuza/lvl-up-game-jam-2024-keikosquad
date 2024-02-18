extends WorldObject
class_name Construction

@export var construction_name: String
var hps = 100
var can_spawn_component = true
var currently_in_range_enemies : Array[Enemy] = []
signal hps_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	global.frogs_placed += 1 
	$life_ticks.start()
	$attack_cooldown.start()
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
		$life_ticks.stop()
		$attack_cooldown.stop()
		var material = load("res://worldobjects/battle/material/material.tscn")
		var instance = material.instantiate()
		var random = RandomNumberGenerator.new()
		var rdm = random.randi_range(0,1)
		instance.material_name = "egg" if rdm else "wood"
		instance.collider_radius = 40
		get_parent().add_child(instance)
		instance.position = Vector2(position.x, position.y + 100)


func _on_static_body_2d_2_input_event(viewport, event, shape_idx):
	print("has input evented")
	if Input.is_action_just_released("tear_down"):
		hps = 0
		hps_changed.emit()
		global.emit_remove_placed_tile(event)


func _on_life_ticks_timeout():
	hps -= 1
	hps_changed.emit()


func _on_detection_zone_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Enemy:
		currently_in_range_enemies.append(body)
		print("added enemy to queue")
		

func _on_detection_zone_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body != null:
		if body is Enemy:
			currently_in_range_enemies.remove_at(currently_in_range_enemies.find(body))

func _on_attack_cooldown_timeout():
	print("tried to attack")
	if currently_in_range_enemies.size() > 0:
		var target = currently_in_range_enemies[0]
		if target != null:
			$StaticBody2D2/AnimatedSprite2D.play(construction_name + " attacking")
			target.get_parent().remove_child(target)
			global.increment_enemies_killed()
