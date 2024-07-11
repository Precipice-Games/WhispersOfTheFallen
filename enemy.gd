extends CharacterBody2D

var speed = 150
var player_chase = false
var player = null
@onready var softCollision = $SoftCollision
var currentHealth = 5

func _physics_process(delta):
	if player_chase:
		position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
	
	if softCollision._is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	

func _on_detection_area_area_entered(_body):
	player =  $"../DungeonBrian"
	player_chase = true

func take_damage():
	currentHealth-=1
	
	if currentHealth <0:
		queue_free()
#func _on_attack_area_body_entered(body):
	#player_chase = false
	
