extends Node2D


# Called when the node enters the scene tree for the first time.


func level_done():

	$DungeonBrian/CUTSCENE.show()

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("Mob")
	if enemies.size() == 0:
		level_done()

