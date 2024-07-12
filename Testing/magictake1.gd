extends Node2D

var lineColor := Color.WHITE
var antialiased := true
const SPELL_LENGTH = 5
var connectionPointRadius := 20.0
var connectionPointColor := Color.DARK_CYAN

var connectionPointsCount := 20
var connectionPoints := []

var currentLinePoints := []

#var SpellBook = Array[]


func _ready():
	randomize()
	var bounds := get_viewport_rect()
	connectionPoints = generatePoints(connectionPointsCount, bounds)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var clickedConnectionPoint = findClosestConnectionPointTo(get_global_mouse_position(), connectionPointRadius)
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
	
	var lineWidth = connectionPointRadius
	for i in range(currentLinePoints.size()):
		var p = currentLinePoints[i]
		if i == currentLinePoints.size() - 1:
			var globalMousePosition = get_global_mouse_position()
			var lineEndpoint = findClosestConnectionPointTo(globalMousePosition, connectionPointRadius)
			#iFIX THIS 	
			lineEndpoint = globalMousePosition
			draw_line(currentLinePoints[i], lineEndpoint, lineColor, lineWidth, antialiased)
		else:
			draw_line(currentLinePoints[i], currentLinePoints[i + 1], lineColor, lineWidth, antialiased)

func generatePoints(count: int, bounds: Rect2):
	var points := []
	for i in range(count):
		var point := Vector2(
			randf_range(bounds.position.x, bounds.end.x),
			randf_range(bounds.position.y, bounds.end.y)
		)
		points.push_back(point)
	return points


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
	if currentLinePoints.size() > SPELL_LENGTH:
		# check to see if the points match a known spell
		currentLinePoints.clear()
	currentLinePoints.push_back(position)

func spellcheck():
	pass

# use loop for array 

