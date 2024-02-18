extends Node2D

@onready var fly_path = preload("res://ennemies/ennemies_path_2d.tscn")

func _ready():
	global.enemies_killed_updated.connect(_on_fly_killed)
	
func _on_fly_killed():
	$Timer.wait_time -= 0.1
	print($Timer.wait_time)
	
func _on_timer_timeout():
	spawn_mob()

func spawn_mob():
	var flyInstance = fly_path.instantiate()
	add_child(flyInstance)
