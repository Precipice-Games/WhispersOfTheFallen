extends CharacterBody2D


const SPEED = 300
const DASHSPEED = 4
@export var dashing = false 
var canDash = true 
@onready var weapon: Node2D = get_node("Weapon")
var currentHealth: int = 50
var damage_zone = false

func _physics_process(_delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if not dashing:
		velocity = input_direction * SPEED
	
	move_and_slide()

func _process(_delta):
	var mouse_direction: Vector2 = (get_global_mouse_position() - self.global_position).normalized()
	weapon.rotation = mouse_direction.angle()
	
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
		velocity = velocity.normalized() * SPEED
		
	# if Input.is_action_pressed("main_attack"):
		#$AnimationPlayer.play("Attack")
	
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

func _input(event):
	if dashing:
		return
	if event.is_action_pressed('dash'):
		if canDash:
			dashing = true 
			$DashTimer.start()
			velocity *= DASHSPEED
			canDash = false
	
	if event.is_action_pressed('main_attack'):
		$Weapon/Scythe/Hitbox/WeaponHitBox.set_disabled(false)
		$AttackTimer.start()
		$WeaponAnimation.play("Attack")

func _on_attack_timer_timeout():
	$Weapon/Scythe/Hitbox/WeaponHitBox.set_disabled(true)
	
func _on_dash_timer_timeout():
	dashing = false
	$DashTimer/DashCooldown.start()

func _on_dash_cooldown_timeout():
	canDash = true 


func _on_player_hitbox_body_entered(body):
	if body.is_in_group("Mob"):
		currentHealth -= 1  #add cooldown
		print(currentHealth)
		$BrianAnim.modulate = Color(1, 0, 0)
		$Tick.start()
	
	if currentHealth <0:
		queue_free()
	

func _on_hitbox_body_entered(body):
	if body.is_in_group("Mob"):
		body.take_damage()
		print('enemy HIT')
		

func _on_tick_timeout():
	$BrianAnim.modulate = Color(1, 1, 1)
