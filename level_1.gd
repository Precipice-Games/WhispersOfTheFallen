extends Node2D

func _ready():
	$DungeonBrian/CUTSCENE.hide()

	
func level_done():
	$DungeonBrian/CUTSCENE.show()

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("Mob")
	if enemies.size() == 0:
		level_done()


