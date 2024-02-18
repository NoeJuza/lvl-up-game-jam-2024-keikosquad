extends CharacterBody2D

signal use_dropper(infos)
signal use_forge(infos)
signal use_scrapper(infos)
signal can_interact_changed

const SPEED = 250
const SoundManager = preload("res://Sound/sfx/sfxController.gd")
var is_dropping: bool = false
var is_holding : bool = false
var held_item : WorldObject = null
var has_interactible_near = false
var interactible_queue : Array[WorldObject] = []
var can_interact = false
func _convert_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y)/2
	return screen_pos
	
func _physics_process(delta):
	var direction = Vector2()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up","ui_down")
	if direction.x != 0 && direction.y != 0:
		direction = Vector2(2 * direction.x,1 * direction.y)
	direction = direction.normalized()
	velocity = direction * SPEED
	# animations
	if direction.x > 0:
		$AnimatedSprite2d.flip_h = false
		if not is_holding:
			$AnimatedSprite2d.play("walking")
		else:
			$AnimatedSprite2d.play("grabbing_walking")
	if direction.x < 0:
		$AnimatedSprite2d.flip_h = true
		if not is_holding:
			$AnimatedSprite2d.play("walking")
		else:
			$AnimatedSprite2d.play("grabbing_walking")
	if direction.x == 0:
		if direction.y != 0:
			if not is_holding:
				$AnimatedSprite2d.play("walking")
			else:
				$AnimatedSprite2d.play("grabbing_walking")
		else:
			if not is_holding:
				$AnimatedSprite2d.play("idle")
			else:
				$AnimatedSprite2d.play("grabbing")
	move_and_slide()
	
	if is_holding:
		if held_item == null:
			is_holding == false
		else:
			var offset
			if not $AnimatedSprite2d.flip_h: 
				offset = _convert_to_isometric(Vector2(0,-80))
			else:
				offset = _convert_to_isometric(Vector2(-80,0))
			held_item.position = position + get_parent().position + offset
		
func _on_interaction_zone_ready():
	print("interaction zone ready")

func _on_interaction_zone_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("body enterred interaction zone")
	var parentNode = body.get_parent()
	if parentNode is WorldObject:
		print(parentNode.type)
		has_interactible_near = true
		interactible_queue.append(parentNode)
		$interaction_tooltip.show()
		$interaction_tooltip.play()
		$tooltip_label.show()

func _on_interaction_zone_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print("body has left zone")
	if not body == null:
		var parentNode = body.get_parent()
		if parentNode is WorldObject:
			var index = interactible_queue.find(parentNode)
			interactible_queue.remove_at(index)
			if interactible_queue.size() == 0:
				has_interactible_near = false
				$interaction_tooltip.hide()
				$interaction_tooltip.stop()
				$tooltip_label.hide()

func _input(ev):
	if Input.is_action_just_pressed("interact"):
		SoundManager.playPrend(self)
		if is_holding :
			for interactible in interactible_queue:
				if interactible.type == "construction" and held_item.type == "component":
					if interactible.hps < 100:
						held_item.queue_free()
						interactible.heal()
						break
				if interactible.type == "dropper" and held_item.type == "component":
					held_item.queue_free()
					#global.add_material_amount()
			is_holding = false
			held_item = null
			is_dropping = true
		elif has_interactible_near and not is_dropping: # pickup item
			for interactible in interactible_queue:
				if interactible.type == "material" or interactible.type == "component":
					is_holding = true
					held_item = interactible
					break
		
	is_dropping = false
