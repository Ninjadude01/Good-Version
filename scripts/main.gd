extends Node2D

var score: int = 0
var level: int = 1
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Setup the level
	current_level_root = get_node("LevelRoot")
	_load_level(level)

# Level Management
func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()
	
	# Change level
	var level_path = "res://scenes/levels/level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "Levelroot"
	_setup_level(current_level_root)

func _setup_level(level_root: Node) -> void:
	
	# connect Exit
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	
	# Connect enemys
	var enemies = level_root.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
	
	# Connect orbs
	var orbs = level_root.get_node_or_null("Orbs")
	if orbs:
		for orb in orbs.get_children():
			orb.collected.connect(increase_score)


#---Signals---
func _on_exit_body_entered(body : Node2D) -> void:
	if body.name == "Player":
		level+=1
		body.can_move = false
		call_deferred("_load_level" ,level)
	
	#Death
func _on_player_died(body):
	print("you died lol")
	body.die()

	#Score#
func increase_score() -> void:
	score += 1
	print(score)
