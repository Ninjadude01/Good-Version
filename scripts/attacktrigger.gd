extends Area2D
@onready var attack_scene = preload("res://scenes//lvl3//attack.tscn")
@onready var attacktrigger: Area2D = $"."
var direction = 1
var check = false


#func _on_body_entered(_body: Node2D):
#	if check == false:
#		check = true
#		var count = 0
#		while count < 100:
#			var attack = attack_scene.instantiate()
#			get_tree().current_scene.add_child(attack)
#			attack.global_position = attacktrigger.global_position + Vector2(direction * 500, 150)
#			await get_tree().create_timer(2.0).timeout
#			count +=1
		
