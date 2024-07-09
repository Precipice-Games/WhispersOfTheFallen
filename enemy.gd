extends CharacterBody2D

var run_speed = 25
var player = null


func _physics_process(_delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	move_and_slide()



func _on_detection_area_area_entered(area):
	player = true
