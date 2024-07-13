extends ColorRect
@onready var start_level = preload("res://Dungeon2/d_2_level_1.tscn")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(start_level)
	
