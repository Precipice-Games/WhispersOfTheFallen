extends CharacterBody2D


const SPEED = 300.0
const speed = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


	
func _physics_process(_delta):
	var _direction = Vector3.ZERO
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("move_left", "move_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony = Input.get_axis("move_up", "move_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = input_direction * speed
	
	move_and_slide()

func _process(_delta):
	@warning_ignore("shadowed_variable_base_class")
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	var _directionx = Vector3.ZERO
	var _directiony = Vector3.ZERO
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if Input.is_action_pressed("main_attack"):
		$AnimationPlayer.play("Attack")
		

