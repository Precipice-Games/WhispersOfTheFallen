extends CharacterBody2D

var speed = 150
@export var player_chase = false
@onready var player = get_tree().get_first_node_in_group("player")
@onready var softCollision = $SoftCollision
var currentHealth = 5
var damage = 2

func _ready():
	set_health_bar()
	$HealthRat.hide()
	
func _physics_process(delta):
	if player_chase:
		self.position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
	
	if softCollision._is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	

func _on_detection_area_area_entered(_body):
	player_chase = true
	$AnimatedSprite2D.play('walk')

func take_damage():
	currentHealth-=1
	$AnimatedSprite2D.modulate = Color(1, 0, 0)
	$Tick.start()
	$HealthRat.show()
	set_health_bar()

	if currentHealth <0:
		queue_free()

func set_health_bar():
	$HealthRat.value = currentHealth 
	

func _on_tick_timeout():
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
