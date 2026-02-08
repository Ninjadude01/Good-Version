extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 450.0
const JUMP_VELOCITY = -1000.0
var alive = true
var can_move = true


func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	
	#Add animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "running"
		
	else:
		animated_sprite_2d.animation = "idle"
		
	#Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"
	
	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("Up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

		if direction == 1.0: 
			animated_sprite_2d.flip_h = true
		elif direction == -1.0: 
			animated_sprite_2d.flip_h = false
		
		
func die() -> void:
	animated_sprite_2d.play("dying")
	alive = false
