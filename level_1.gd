extends Node2D


	
func level_done():
	$DungeonBrian/CUTSCENE2.show()

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("Mob")
	if enemies.size() == 0:
		level_done()


