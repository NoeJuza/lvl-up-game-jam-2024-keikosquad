extends Node2D

static var prend = preload("res://Sound/sfx/je_prends_01.wav")

func _process(delta: float) -> void:
	pass

static func playPrend(node):
	playSound(node, prend)

static func playSound(node, sound):
	var n = AudioStreamPlayer2D.new()
	n.set_name("kek")
	node.add_child(n)
	n.volume_db = -10
	n.stream = sound
	n.play()
