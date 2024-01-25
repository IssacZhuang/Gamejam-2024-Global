extends Node

@export var endPoint: Node2D
@export var startPoint: Node2D

var is_game_start = false

var endPointsPositons: Array[Array]
var startPositon = Vector2(250, 1900)

var endPointsList: Array[Node2D]

func _ready():
	endPointsPositons = [
		[5400, 1920, endPoint.endpoint_type.BothEnd],
		[2700, 1920, endPoint.endpoint_type.BothEnd]
	]
	startPoint.position = startPositon
	for endPointPositon in endPointsPositons:
		var point = EndPosition.new()
		point.position = Vector2(endPointPositon[0], endPointPositon[1])
		point.endpointType = endPointPositon[2]
		point.is_active = true
		endPointsList.append(point)
		add_child(point)

func _process(delta):
	pass
		
func start():
	is_game_start = true
	startPoint.show()
	for ep in endPointsList:
		ep.show()

