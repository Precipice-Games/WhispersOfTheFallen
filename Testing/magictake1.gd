extends Node2D

signal healspell

var lineColor := Color.WHITE
var antialiased := true
const SPELL_LENGTH = 3
var connectionPointRadius := 10.0

var connectionPointColor := Color.WHITE

var connectionPointsCount := 8
var connectionPoints := []

var currentLinePoints := []
var radius = 165

var example_spell:Array
var example_spell_effect:Callable = heal


#(330, 0) 0
#(233.3452, 233.3452) 1
#(0, 330) 2
#(-233.3452, 233.3452) 3
#(-330, 0) 4    4 7  6
#(-233.3452, -233.3452) 5
#(-0, -330) 6
#(233.3452, -233.3452) 7

func _ready():
	example_spell = [Vector2(-165 , 0),Vector2(116.6726, -116.6726),Vector2(-0, -165)] #476


	var bounds := get_viewport_rect()
	connectionPoints = generatePoints(connectionPointsCount, bounds)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var relativeMousePosition = get_global_mouse_position() - global_position
			var clickedConnectionPoint = findClosestConnectionPointTo(relativeMousePosition, connectionPointRadius)
			print("Clicked at ", relativeMousePosition)
			if not clickedConnectionPoint:
				return
			updateCurrentLineWith(clickedConnectionPoint)
			queue_redraw()


func _process(delta):
	if currentLinePoints.size() == 1:
		queue_redraw()


func _draw():
	for connectionPoint in connectionPoints:
		draw_circle(connectionPoint, connectionPointRadius, connectionPointColor)
	
	var lineWidth = connectionPointRadius - 5
	for i in range(currentLinePoints.size()):
		var p = currentLinePoints[i]
		if i == currentLinePoints.size() - 1:
			var relativeMousePosition = get_global_mouse_position() - global_position
			print("Clicked at ", relativeMousePosition)
			var lineEndpoint = findClosestConnectionPointTo(relativeMousePosition, connectionPointRadius)
			lineEndpoint = relativeMousePosition
			draw_line(currentLinePoints[i], lineEndpoint, lineColor, lineWidth, antialiased)
		else:
			draw_line(currentLinePoints[i], currentLinePoints[i + 1], lineColor, lineWidth, antialiased)

func generatePoints(count: int, bounds: Rect2):
	var points := []
	for i in range(8):
		var point := Vector2(
			radius * cos(i * PI/4),
			radius * sin(i * PI/4)
		)
		points.push_back(point)
		print(point)
	points.push_back(position)
	print(position)
	return points
#for loop counts i  from 0 up to 7: i * 45(deg) 

func findClosestConnectionPointTo(aPoint: Vector2, maxDistance: float):
	var closestPoint = null
	var closestDistance = INF
	for connectionPoint in connectionPoints:
		var distance = connectionPoint.distance_to(aPoint)
		if distance <= maxDistance:
			if not closestPoint or distance < closestDistance:
				closestPoint = connectionPoint
				closestDistance = distance
	return closestPoint


func updateCurrentLineWith(position: Vector2):
	print(position)
	currentLinePoints.push_back(position)
	if currentLinePoints.size() >= SPELL_LENGTH:
		var current_spell = currentLinePoints
		if check_spell(current_spell, example_spell):
			example_spell_effect.call() 
		currentLinePoints.clear()


# use loop for array 

func check_spell(current_spell, example_spell):
	print(current_spell.size())
	for i in range(current_spell.size()):
		if not current_spell[i].is_equal_approx(example_spell[i]):
			print('test')
			return false
	return true 

func heal():
	emit_signal("healspell")

	
