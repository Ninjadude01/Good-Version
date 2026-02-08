extends Area2D
@onready var gate: StaticBody2D = $"../Gate"
var once = false

func _on_body_entered(_body: Node2D) -> void:
	
	if once == false:
		once = true
		
		var tween = create_tween()
		tween.tween_property(gate,"position:y",gate.position.y + 390, 1
		).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
			
		tween.finished.connect(func():
				gate.get_node("CollisionShape2D").call_deferred("set_disabled", false)
				once = true)
			
