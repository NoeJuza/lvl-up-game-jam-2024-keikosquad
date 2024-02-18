extends WorldObject
class_name RawMaterial
@export var material_name : String
@export var collider_radius : float
# Called when the node enters the scene tree for the first time.
func _ready():
	var texture : Texture2D = global.materials[material_name].texture
	$StaticBody2D2/CollisionShape2D.shape.radius = collider_radius
	print(texture.get_width())
	var temp_scale_x : float = (collider_radius*2.0)/texture.get_height()
	$StaticBody2D2/Sprite2D.texture = texture
	$StaticBody2D2/Sprite2D.scale.x = temp_scale_x
	$StaticBody2D2/Sprite2D.scale.y = temp_scale_x
	print($StaticBody2D2/Sprite2D.scale.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
