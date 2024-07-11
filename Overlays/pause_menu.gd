extends CanvasLayer


@onready var pause_menu = $"."
var paused = false

func _process(delta):
	paused = false
	if  Input.is_action_pressed("pause"):
		pass

func pause(state):
	if state:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false

	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
