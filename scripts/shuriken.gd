extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var speed = 500
@export var rotation_speed = 10
@export var lifetime = 2.0
var direction = 1


func _ready():
	area_entered.connect(_on_area_entered)
	if direction < 0:
		sprite_2d.flip_h = true
	

	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):

	position.x += direction * speed * delta
	rotation += rotation_speed * direction * delta
	

func _on_area_entered(area):
	
	print("hit", area.name)
	queue_free()
	
