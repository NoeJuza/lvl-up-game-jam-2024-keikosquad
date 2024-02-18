extends Node2D

@onready var fly_path = preload("res://ennemies/ennemies_path_2d.tscn")

func _on_timer_timeout():
	spawn_mob()

func spawn_mob():
	var flyInstance = fly_path.instantiate()
	add_child(flyInstance)
