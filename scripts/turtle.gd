extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar


signal player_died
const SPEED = 100
var direction = 1
var health = 100

func _ready():
	health_bar.value = health
	
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
	

func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive:
		emit_signal("player_died", body)
	

func _on_area_entered(_area: Area2D) -> void:
	health -= 20
	health_bar.value = health
	
	if health <=0:
		queue_free()
