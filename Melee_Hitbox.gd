extends Area2D

var activation_time:float = 0
var recovery_time:float = 0
var attack_per_sec = 2


func activate():
	await get_tree().create_timer(0.5).timeout #start up time
	$Detector.disabled = false
	deactivate()
	
	
func deactivate():
	await get_tree().create_timer(0.5).timeout #attack lenght time
	$Detector.disabled = true

func _physics_process(delta):
	rotate(delta * deg_to_rad(360) * attack_per_sec)
