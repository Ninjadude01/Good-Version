extends Area2D
@onready var barrier: StaticBody2D = $"../Barrier"

func _on_gate_trigger_body_entered(_body: Node2D):
	print("gatedrop")
	
	var tween = create_tween()
	tween.tween_property(
		barrier, 
		"position:y", 
		barrier.position.y + 500, 0.6
	).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(func():
		barrier.get_node("CollisionShape2D").call_deferred("set_disabled", false))
	
