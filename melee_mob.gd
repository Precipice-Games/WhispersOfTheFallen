extends CharacterBody2D


var speed = 150
var player_chase = false
@onready var player = get_tree().get_first_node_in_group("player")

# var player_direction = player.position - self.position 
func _physics_process(delta):
	if player_chase:
		self.position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		

func _on_attack_area_body_entered(_body):
	print("Attacking")
	$Melee_Hitbox.activate() # attack player
	

func _on_detection_area_body_entered(_body):
	player_chase = true
