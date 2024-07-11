extends CharacterBody2D

@export var player:CharacterBody2D

# var player_direction = player.position - self.position 


func _on_attack_area_body_entered(_body):
	print("Attacking")
	$Melee_Hitbox.activate() # attack player
	

func _on_detection_area_body_entered(_body):
	pass # Chase the player

