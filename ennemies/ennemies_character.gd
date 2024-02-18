extends CharacterBody2D
class_name Enemy
@export var speed = 150


# Déterminez les poids des couleurs en fonction de 'wave'
var red_weight = global.wave * 0.3 # Ajustez ces valeurs selon vos besoins
var black_weight = 1.0 - red_weight

# Choisissez aléatoirement en fonction des poids
var color = "red" if randf() < red_weight else "black"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		get_tree().change_scene_to_file("res://UI/menus/game-over.tscn")

func _physics_process(delta):
	if color == "black":
		$AnimatedSprite.play("black")
	else:
		$AnimatedSprite.play("red")

