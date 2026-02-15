extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var speed = 450.0
const JUMP_VELOCITY = -1000.0
var alive = true
var can_move = true
var facing = 1

@export var shuriken_scene: PackedScene
@export var normal_speed = 450.0
@export var acceleration = 1000
@export var friction = 700

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
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
			
		if Input.is_action_just_pressed("Up2") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("Left", "Right")
		
		if direction !=0: 
			velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
		
		else:
			velocity.x = move_toward(velocity.x, 0, friction * delta)


		move_and_slide()

		if direction == 1.0: 
			animated_sprite_2d.flip_h = true
			facing = 1
		elif direction == -1.0: 
			facing = -1
			animated_sprite_2d.flip_h = false
		
		
func die() -> void:
	animated_sprite_2d.play("dying")
	alive = false
	
func shoot(): 
	var shuriken = shuriken_scene.instantiate()
	shuriken.position = position + Vector2(facing * 100, 0)
	shuriken.direction = facing
	get_parent().add_child(shuriken)
