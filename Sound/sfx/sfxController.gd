extends Node2D

static var prend = preload("res://Sound/sfx/je_prends_01.wav")
static var pose = preload("res://Sound/sfx/je_pose_02.wav")
static var grenouille = preload("res://Sound/sfx/frog-croak1.wav")
static var click = preload("res://Sound/sfx/cliquez.wav")


func _process(delta: float) -> void:
	pass

static func playPrend(node):
	playSound(node, prend)
	
static func playPose(node):
	playSound(node, pose)
	
static func playGrenouille(node):
	playSound(node, grenouille)
	
static func playClick(node):
	playSound(node, click)

static func playSound(node, sound):
	var n = AudioStreamPlayer2D.new()
	n.set_name("kek")
	node.add_child(n)
	n.volume_db = -10
	n.stream = sound
	n.play()
