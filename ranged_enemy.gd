extends CharacterBody2D


var speed = 150
var player_chase = false

#@onready var Melee_Hitbox = $Melee_Hitbox
@export var player:CharacterBody2D
@export var Arrrow_Scene: PackedScene


# var player_direction = player.position - self.position 
func _physics_process(delta):
	var direction = (player.position - self.position).normalized()
	if player_chase:
		self.position += direction * speed * delta
		move_and_collide(Vector2(0,0)) 
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	#if Melee_Hitbox._is_colliding():
		#velocity += Melee_Hitbox.get_push_vector() * delta * 400

func _on_area_hit_box_body_entered(_body):
	print("Attacking")
	$Area_HitBox.activate() # attack player
	

func _on_detection_area_body_entered(_body):
	player =  $"../DungeonBrian"
	print(_body.name)
	player_chase = true




func _on_attack_timer_timeout():
	print("shoot arrow")
	var arrow:Area2D = Arrrow_Scene.instantiate()
	owner.add_child(arrow)
	var arrow_position = self.position
	var player_direction:Vector2 = (player.position - self.position).normalized()
	arrow.rotate(Vector2.RIGHT.angle_to(player_direction))
	#player_direction = arrow
	arrow.position = arrow_position
	
	# set arrow's initial position (probably at the ranged enemy)
	# set the arrow's direction/velocity
	# add the arrow to the scene (as a child of the level node


func _on_attack_area_body_entered(body):
		player =  $"../DungeonBrian"
		player_chase = false
		$Attack_Timer.start()


func _on_attack_area_body_exited(body):
	$Attack_Timer.stop()
	player_chase = true


func _on_detection_area_body_exited(body):
	player_chase = false
