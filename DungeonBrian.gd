extends CharacterBody2D


const speed = 300.0
const JUMP_VELOCITY = -400.0


	
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	
