extends Control

@onready var pausemenu = $".."
func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_button_pressed():
	pass  #home screen


func _on_keybind_button_pressed():
	pass # keybind menu
	
	


func _on_resume_button_pressed():
	pausemenu.hide() 
	get_tree().paused = false
