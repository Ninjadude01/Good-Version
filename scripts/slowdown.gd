extends Area2D

func _on_body_entered(body):
	if body.name == "Player": 
		body.speed = 250
	
func _on_body_exited(body):
	if body.name == "Player":
		body.speed = body.normal_speed
