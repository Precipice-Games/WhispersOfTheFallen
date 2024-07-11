extends CharacterBody2D

@export var player:CharacterBody2D
@export var Melee_Scene : PackedScene = preload("res://Melee_Hitbox.tscn")
var Melee_Hitbox = Melee_Scene.instantiate()

# var player_direction = player.position - self.position 




func _on_attack_area_body_entered(body):
	print("Attacking")
	Melee_Hitbox.activate() # attack player
	

func _on_detection_area_body_entered(body):
	pass # Chase the player


