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
		endPoint.position = Vector2(endPointPositon[0], endPointPositon[1])
		endPoint.endpointType = endPointPositon[2]
		endPoint.is_active = true
		endPointsList.append(endPoint)
		add_child(endPoint)

func _process(delta):
	pass
		
func start():
	is_game_start = true
	startPoint.show()
	for ep in endPointsList:
		ep.show()

