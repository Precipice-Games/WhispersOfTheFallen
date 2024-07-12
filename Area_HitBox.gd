extends Area2D

var activation_time:float = 0
var recovery_time:float = 0
var attack_per_sec = 2
var speed = 50

func _physics_process(delta):
	self.position += speed * delta

func activate():
	await get_tree().create_timer(0.5).timeout #start up time
	$Arrow.disabled = false
	deactivate()
	
	
func deactivate():
	await get_tree().create_timer(0.5).timeout #attack lenght time
	$Arrow.disabled = true
