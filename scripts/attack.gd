extends Area2D

signal player_died
var speed = 700
var direction = -1
var lifetime = 2.0


func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _physics_process(delta):
	position.x += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive:
		emit_signal("player_died", body)
		queue_free()
