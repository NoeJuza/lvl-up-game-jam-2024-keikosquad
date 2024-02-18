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
	#print("interaction zone ready")
	pass

func _on_interaction_zone_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print("body enterred interaction zone")
	var parentNode = body.get_parent()
	if parentNode is WorldObject:
		#print(parentNode.type)
		has_interactible_near = true
		interactible_queue.append(parentNode)

func _on_interaction_zone_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	#print("body has left zone")
	if not body == null:
		var parentNode = body.get_parent()
		if parentNode is WorldObject:
			var index = interactible_queue.find(parentNode)
			interactible_queue.remove_at(index)
			if interactible_queue.size() == 0:
				has_interactible_near = false
				$tooltip_label.hide()
				$interaction_tooltip.hide()
				$interaction_tooltip.stop()

func _input(ev):
	if has_interactible_near:
		var possible_interaction_result = compute_possible_interaction()
		var possible_interaction = possible_interaction_result[0]
		var interactible = possible_interaction_result[1]
		#print(possible_interaction)
		if not possible_interaction == "none":
			$interaction_tooltip.show()
			$interaction_tooltip.play()
			$tooltip_label.show()
		match possible_interaction:
			"none":
				$interaction_tooltip.hide()
				$interaction_tooltip.stop()
				$tooltip_label.hide()
			"pickup":
				$tooltip_label.text = "Ramasser"
			"drop":
				$tooltip_label.text = "Déposer"
			"heal":
				$tooltip_label.text = "Soigner"
			"craft":
				$tooltip_label.text = "Fabriquer"
			"recycle":
				$tooltip_label.text = "Recycler"
			"store":
				$tooltip_label.text = "Envoyer"
		if Input.is_action_just_pressed("interact"):
			match possible_interaction:
				"pickup":
					is_holding = true
					held_item = interactible
				"drop":
					is_holding = false
					held_item = null
					is_dropping = true
				"heal":
					get_parent().remove_child(held_item)
					held_item = null
					is_holding = false
					interactible.heal()
				"craft":
					get_parent().remove_child(held_item)
					is_holding = false
					held_item = null
					interactible.craft()
				"recycle":
					get_parent().remove_child(held_item)
					is_holding = false
					held_item = null
					interactible.craft()
				"store":
					get_parent().remove_child(held_item)
					is_holding = false
					#print(held_item.component_name)
					global.add_stock_amount(held_item.component_name, 1)
					held_item = null

	is_dropping = false
func compute_possible_interaction():
	if has_interactible_near:
		if is_holding :
			SoundManager.playPose(self)
			for interactible in interactible_queue:
				if interactible.type == "construction" and held_item.type == "component":
					if interactible.hps < 100:
						return ["heal", interactible]
				if interactible.type == "dropper" and held_item is Component:
					return ["store", interactible]
				if interactible is Forge and held_item is RawMaterial:
					if interactible.accepted_material == held_item.material_name and not interactible.is_busy:
						return ["craft", interactible]
				if interactible is Scrapper and held_item is Component:
					if interactible.accepted_component == held_item.component_name and not interactible.is_busy:
						return ["recycle", interactible]
			return ["drop",null]
		elif not is_dropping: # pickup item
			for interactible in interactible_queue:
				if interactible.type == "material" or interactible.type == "component":
					return ["pickup",interactible]
	return ["none",null]
