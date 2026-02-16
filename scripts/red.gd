extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar

signal player_died

var health = 100

func _ready() -> void:
	health_bar.value = health


func _on_area_entered(_area: Area2D) -> void:
	health -= 20
	health_bar.value = health
	
	if health <= 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive:
		emit_signal("player_died", body)
