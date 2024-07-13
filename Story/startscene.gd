extends Control

@onready var start_level = preload("res://Dungeon2/d_2_level_1.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().change_scene_to_packed(start_level)
