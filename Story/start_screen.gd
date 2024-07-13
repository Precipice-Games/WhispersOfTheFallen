extends Control

@onready var start_level = preload("res://Story/startscene.tscn")
@onready var credit = preload("res://Credit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_packed(start_level)


func _on_credits_pressed():
	get_tree().change_scene_to_packed(credit)
