extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var player_direction = Vector2()

var speed = 250 ##TODO setup movement variables

func _physics_process(delta):
	player_direction = player.global_position - self.global_position
	velocity = player_direction  * speed
	move_and_slide()
