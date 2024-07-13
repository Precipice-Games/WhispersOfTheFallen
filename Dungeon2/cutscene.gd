extends Control


@onready var next_level1 = preload("res://level_1.tscn")


func _on_go_on_pressed():
	get_tree().change_scene_to_packed(next_level1)

#func _input(event):

