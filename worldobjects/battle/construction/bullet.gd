extends Area2D

var speed = 300

func _ready():
	set_process(true)

func _process(delta):
	# Déplacez la balle vers le haut
	position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	# Détruisez la balle lorsqu'elle quitte l'écran
	queue_free()
