extends WorldObject
class_name Scrapper
@export var accepted_component: String
@export var output_material: String
var is_busy: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var texture : Texture2D = global.scrappers[accepted_component].texture
	print(texture.get_width())
	var temp_scale_x : float = 0.5
	$StaticBody2D2/Sprite2D.texture = texture
	$StaticBody2D2/Sprite2D.scale.x = temp_scale_x
	$StaticBody2D2/Sprite2D.scale.y = temp_scale_x
	print($StaticBody2D2/Sprite2D.scale.x)

func craft():
	is_busy = true
	$Timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Timer.stop()
	create_material_in_front()
	is_busy = false

func create_material_in_front():
	var component = load("res://worldobjects/battle/material/material.tscn")
	var instance = component.instantiate()
	instance.material_name = output_material
	instance.collider_radius = 40
	get_parent().add_child(instance)
	instance.position = Vector2(position.x, position.y - 100)
