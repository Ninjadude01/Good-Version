extends Node2D

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	#connect orb
	var orbs = $Levelroot.get_node_or_null("Orbs")
	if orbs:
		for orb in orbs.get_children():
			orb.collected.connect(increase_score)

#score#
func increase_score() -> void:
	score += 1
	print(score)
