extends Control

@onready var start_level = preload("res://Story/start_screen.tscn")

func input(event):
	if event.is_action_pressed('pause'):
		get_tree().change_scene_to_packed(start_level)
		print('hi')
		
	


func _on_credits_pressed():
	get_tree().change_scene_to_packed(start_level)
