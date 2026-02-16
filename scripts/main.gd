extends Node2D
@onready var fade: ColorRect = $HUD/Fade
@onready var score_label: Label = $"HUD/Score Panel/Score Label"
@onready var death_label: Label = $"HUD/Death Panel/Death Label"



var score: int = 0
var level: int = 1
var deathnum = 0
var current_level_root: Node = null
var levels = {
	1: preload("res://scenes/levels/level1.tscn"),
	2: preload("res://scenes/levels/level2.tscn"),
	3: preload("res://scenes/levels/level3.tscn"),
	4: preload("res://scenes/levels/level4.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Setup the level
	fade.modulate.a = 1.0
	current_level_root = get_node("LevelRoot")
	await _load_level(level, true, false)

# Level Management
func _load_level(level_number: int, first_load: bool, reset_score: bool) -> void:
	#Fade out
	if not first_load:
		await _fade(1.0)
		
	if reset_score:
		score = 0
		
	if current_level_root:
		current_level_root.queue_free()
	
	# Change level
	var level_path = "res://scenes/levels/level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "Levelroot"
	_setup_level(current_level_root)


	
	#Fade in
	await _fade(0.0)

func _setup_level(level_root: Node) -> void:
	
	# Connect Exit
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

	#Level Change
func _on_exit_body_entered(body : Node2D) -> void:
	if body.name == "Player":
		level+=1
		body.can_move = false
		await _load_level(level, false, false)
	
	#Death
func _on_player_died(body):
	body.die()
	score = 0
	score_label.text = "Orb Power  
 	Level: %s" %score
	deathnum+=1
	death_label.text = "Deaths: %s" %deathnum
	await _load_level(level, false ,true)
	

	#Score
func increase_score() -> void:
	score += 1
	score_label.text = "Orb Power 
	 Level: %s" %score
	
	#Fade
func _fade(to_alpha: float) -> void:
	var tween := create_tween()
	tween.tween_property(fade, "modulate:a", to_alpha, 1.5)
	await tween.finished
