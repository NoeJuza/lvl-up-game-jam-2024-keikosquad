extends CharacterBody2D


const SPEED = 250

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
	direction = _convert_to_isometric(direction)
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()
