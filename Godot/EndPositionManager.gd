extends Node

@export var endPointsTemplate: EndPosition
@export var startPositon: Node2D
var endPoints: Array[EndPosition]

var is_game_start = false

func _ready():
	startPositon.show()

func _process(delta):
	if is_game_start:
		startPositon.position = Vector2(100, 900)
		
		endPointsTemplate.endpointType = endPointsTemplate.endpoint_type.BothEnd
		endPointsTemplate.is_active = true
		endPointsTemplate.position = Vector2(1744, 911)
		
