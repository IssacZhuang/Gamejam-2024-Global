@tool
extends Node
class_name FlyBugs

@export var node1: Node2D
@export var node2: Node2D
@export var line: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if line == null:
		return
	if node1 == null:
		return
	if node2 == null:
		return
	var lineWidth = line.texture.get_width()
	var distance = node1.global_position.distance_to(node2.global_position)
	var scale = distance / float(lineWidth)
	line.scale.x = scale
	var midPoint = node1.global_position.lerp(node2.global_position, 0.5)
	line.global_position = midPoint
	line.rotation = atan((node2.global_position.y - node1.global_position.y) / (node2.global_position.x - node1.global_position.x))
	pass

func SetStartPosition(pos: Vector2):
		node1.global_position = pos
		
func SetEndPosition(pos: Vector2):
		node2.global_position = pos
