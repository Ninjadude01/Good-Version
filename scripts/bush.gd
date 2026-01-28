extends Node2D
var direction = -1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _start() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
