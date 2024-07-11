extends Area2D
class_name softCollision

func _is_colliding():
	var areas = get_overlapping_areas()
	return areas.size( ) > 0
	

func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO 
	if _is_colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	return push_vector

var push_velocity = Vector2()
var direction = Vector2.ZERO
@export var push_strength = 50

func _physics_process(delta):
	var overlapping_areas = get_overlapping_areas()
	if(overlapping_areas.size() != 0):
		var area = overlapping_areas[0]
		if(area != null):
			var colliding_entity = area.owner
			direction = colliding_entity.global_position.direction_to(global_position)
			push_velocity =  direction * push_strength
			push_velocity = owner.move_and_slide()
