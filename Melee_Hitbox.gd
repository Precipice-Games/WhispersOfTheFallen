extends Area2D

var activation_time:float = 0
var recovery_time:float = 0
var attack_per_sec = 2


func activate():
	$Detector.disabled = false
	
func deactivate():
	$Detector.disabled = true

func _physics_process(delta):
	pass
	rotate(delta * deg_to_rad(360) * attack_per_sec) 
