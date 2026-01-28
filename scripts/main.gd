extends Node2D

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	
	#connect enemys
	var enemies = $Levelroot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
	
	#connect orbs
	var orbs = $Levelroot.get_node_or_null("Orbs")
	if orbs:
		for orb in orbs.get_children():
			orb.collected.connect(increase_score)


#---signals---

	#death
func _on_player_died(body):
	print("you died lol")
	body.die()

	#score#
func increase_score() -> void:
	score += 1
	print(score)
