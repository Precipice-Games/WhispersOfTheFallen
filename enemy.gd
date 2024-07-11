extends CharacterBody2D

var speed = 150
var player_chase = false
var player = null
@onready var softCollision = $SoftCollision

func _physics_process(delta):
	if player_chase:
		position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
	
	if softCollision._is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
func _on_detection_area_area_entered(_body):
	player =  $"../DungeonBrian"
	player_chase = true
