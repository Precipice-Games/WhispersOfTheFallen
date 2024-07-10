extends CharacterBody2D


const SPEED = 300.0
const speed = 300.0



	
func _physics_process(_delta):
	var _direction = Vector3.ZERO
	
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
	
	#DIRECTIONAL RUNNING
	if Input.is_action_pressed("move_up"):
		if Input.is_action_pressed("move_left"):
			$BrianAnim.play('UL')

		elif Input.is_action_pressed("move_right"):
			$BrianAnim.play('UR')

		else:
			$BrianAnim.play('U')

	if Input.is_action_pressed("move_down"):
		if Input.is_action_pressed("move_left"):
			$BrianAnim.play('DL')

		elif Input.is_action_pressed("move_right"):
			$BrianAnim.play('DR')

		else:
			$BrianAnim.play('D')
			
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("move_down"):
			$BrianAnim.play('DL')

		elif Input.is_action_pressed("move_up"):
			$BrianAnim.play('UL')

		else:
			$BrianAnim.play('L')

	if Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_down"):
			$BrianAnim.play('DR')

		elif Input.is_action_pressed("move_up"):
			$BrianAnim.play('UR')

		else:
			$BrianAnim.play('R')
