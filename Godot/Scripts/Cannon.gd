@tool
extends Node2D
class_name Cannon

@export var barrelCenter: Node2D
@export var focusPoint: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if barrelCenter == null:
		return
	if focusPoint == null:
		return
	barrelCenter.rotation = atan((focusPoint.position.y - barrelCenter.position.y) / (focusPoint.position.x - barrelCenter.position.x))
	pass

func SetFocusPosition(focusPosition: Vector2):
	focusPoint.position = focusPosition
