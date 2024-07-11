extends Area2D

var activation_time:float = 0
var recovery_time:float = 0

func activate():
	$Detector.disabled = false
	
func deactivate():
	$Detector.disabled = true
