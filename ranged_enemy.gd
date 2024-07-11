extends CharacterBody2D


var speed = 150
var player_chase = false
var player_null = null
#@onready var Melee_Hitbox = $Melee_Hitbox
@export var player:CharacterBody2D

# var player_direction = player.position - self.position 
func _physics_process(delta):
	if player_chase:
		position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		
	#if Melee_Hitbox._is_colliding():
		#velocity += Melee_Hitbox.get_push_vector() * delta * 400

func _on_area_hit_box_body_entered(_body):
	print("Attacking")
	$Area_HitBox.activate() # attack player
	

func _on_detection_area_body_entered(_body):
	player_null =  $"DungeonBrian"
	player_chase = true


