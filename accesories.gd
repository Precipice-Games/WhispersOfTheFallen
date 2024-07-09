extends TileMap
pass
# Reference to the player node
@onready var player = $"../DungeonBrian"

# Reference to the tilemap node

func _process(delta):
	# Compare player's y-position with tilemap's position
	var player_y = player.global_position.y
	var tilemap_y = global_position.y

	# Determine if player should be in front or behind the tilemap
	if player_y > tilemap_y:
		# Bring player in front of tilemap
		z_index = z_index + 1
	else:
		# Send player behind tilemap
		z_index = z_index - 1
