extends WorldObject
class_name RawMaterial
@export var material_name : String
@export var texture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D2/Sprite2D.texture = texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
