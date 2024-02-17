extends CharacterBody2D

signal use_dropper(infos)
signal use_forge(infos)
signal use_scrapper(infos)

const SPEED = 250
var is_dropping: bool = false
var is_holding : bool = false
var held_item : WorldObject = null
var has_item_near = false
var last_entered_item_array : Array[WorldObject] = []

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
		has_item_near = true
		last_entered_item_array.append(parentNode)

func _on_interaction_zone_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print("body has left zone")
	var parentNode = body.get_parent()
	if parentNode is WorldObject:
		var index = last_entered_item_array.find(parentNode)
		last_entered_item_array.remove_at(index)
		if last_entered_item_array.size() == 0:
			has_item_near = false

func _input(ev):
	if Input.is_action_just_pressed("interact"):
		if is_holding :
			is_holding = false
			held_item = null
			is_dropping = true
		elif has_item_near and not is_dropping:
			is_holding = true
			held_item = last_entered_item_array[0]
	is_dropping = false
