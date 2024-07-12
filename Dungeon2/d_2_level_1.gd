extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().reload_current_scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_detector_body_exited(body):
		print('dead')
