extends WorldObject
class_name Forge
@export var accepted_material: String
@export var output_component: String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = accepted_material + " -> " + output_component

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
