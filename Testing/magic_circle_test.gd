extends Sprite2D


signal pressed
signal mouseover
signal mouseleft

func _ready():
	pass # Replace with function body.


func _on_Area2D_input_event(viewport, event, shape_idx):
		emit_signal("pressed")
	

func change_sprite(spritenumber):
	frame=spritenumber


func _on_area_2d_mouse_entered():
	emit_signal("mouseover")
	$Area2D/ColorRect.modulate = Color(1, 0, 0)
	print('test')


func _on_area_2d_mouse_exited():
	emit_signal("mouse_left")
	$Area2D/ColorRect.modulate = Color(1, 1, 1)
