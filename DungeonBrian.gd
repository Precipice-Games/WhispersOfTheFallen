extends CharacterBody2D


const SPEED = 300
const DASHSPEED = 4
@export var dashing = false 
var canDash = true 
@onready var weapon: Node2D = get_node("Weapon")
var currentHealth: int = 100
var pending_damage: int = 0 
@onready var test = $Test
@onready var game_over = preload("res://Dungeon2/GAMEOVER.tscn")
var currentMana: int = 100


func _ready():
	set_health_bar()
	$Test.hide()
	$Bleed.hide()
	set_mana_bar()

	
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
	
	if Input.is_action_pressed("spellcast"):
		if currentMana <50:
			null
		if currentMana >=50:
			if $Test.visible:
				$Weapon/Scythe.show()
				$Test.hide()
				print('hello')
			else:
				$Weapon/Scythe.hide()
				$Test.show()
		

func _on_attack_timer_timeout():
	$Weapon/Scythe/Hitbox/WeaponHitBox.set_disabled(true)
	
func _on_dash_timer_timeout():
	dashing = false
	$DashTimer/DashCooldown.start()

func _on_dash_cooldown_timeout():
	canDash = true 


func _on_player_hitbox_body_entered(body):
	if body.is_in_group("Mob"):
		pending_damage += body.damage

func set_health_bar():
	$HealthBar.value = currentHealth + 30

func set_mana_bar():
	$ManaBar.value = currentMana + 30
	
func _on_hitbox_body_entered(body):
	if body.is_in_group("Mob"):
		body.take_damage()
		print('enemy HIT')
		

func _on_tick_timeout():
	$BrianAnim.modulate = Color(1, 1, 1)
	$Bleed.hide()


# dmage timer constant timeout, assign var values to everything
# removes dmg from pendign dmg timer after mobs exits body


func _on_damage_timer_timeout():
	if pending_damage > 0:
		currentHealth = currentHealth - pending_damage
		print(currentHealth)
		$BrianAnim.modulate = Color(1, 0, 0)
		$Bleed.show()
		$Tick.start()
		set_health_bar() 
	if currentHealth <30:
		$Bleed.modulate = Color(1,0,0)
	if currentHealth <0:
		get_tree().change_scene_to_packed(game_over)


func _on_player_hitbox_body_exited(body):
	if body.is_in_group("Mob"):
		pending_damage -= body.damage


func _on_player_hitbox_area_entered(area):
		if area.is_in_group("Projectile"):
			currentHealth -= 10
			set_health_bar()
			$BrianAnim.modulate = Color(1, 0, 0)
			$Bleed.show()
			$Tick.start()


func _on_test_healspell():
	$Test.hide()
	$Weapon/Scythe.show()
	if currentMana >=50:
		currentHealth += 50
		currentMana -= 50 
		set_mana_bar()
		set_health_bar()
		$BrianAnim.modulate = Color(0, 1, 0)
		$Tick.start()
