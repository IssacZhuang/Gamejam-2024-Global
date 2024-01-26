extends Node2D

@export var endPoint : PackedScene = load("res://Scenes/Nodes/LevelManager/end_position.tscn")
@export var startPoint : PackedScene = load("res://Scenes/Nodes/LevelManager/start_position.tscn")


var is_game_start = false

var endPointsPositons: Array[Array]
var startPositon = Vector2(250, 1600)

var endPointsList: Array[Node2D]

func _ready():
	endPointsPositons = [
		[5400, 1920, EndPosition.endpoint_type.BothEnd],
		[2700, 1920, EndPosition.endpoint_type.BothEnd]
	]
	var currentStartPoint = startPoint.instantiate()
	currentStartPoint.position = startPositon
	add_child(currentStartPoint)
	for endPointPositon in endPointsPositons:
		var point = endPoint.instantiate()
		point.position = Vector2(endPointPositon[0], endPointPositon[1])
		point.endpointType = endPointPositon[2]
		point.is_active = true
		endPointsList.append(point)
		add_child(point)

func _process(delta):
	pass
		
