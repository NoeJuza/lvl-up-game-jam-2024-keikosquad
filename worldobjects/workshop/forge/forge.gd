extends WorldObject
class_name Forge
@export var accepted_material: String
@export var output_component: String
var is_busy: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = accepted_material + " -> " + output_component
	var texture : Texture2D = global.forges[accepted_material].texture
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
	pass # Replace with function body.
