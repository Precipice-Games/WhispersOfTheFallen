extends CharacterBody2D

var speed = 175
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 


func _on_detection_area_area_entered(_body):
	player =  $"../DungeonBrian"
	player_chase = true
	print("hii")
