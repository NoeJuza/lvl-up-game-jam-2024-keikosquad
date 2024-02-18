extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$flies_label.text = str(global.enemies_killed)
	$frogs_label.text = str(global.frogs_placed)
	$score_label.text = str(global.enemies_killed * 100 - global.frogs_placed * 1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
