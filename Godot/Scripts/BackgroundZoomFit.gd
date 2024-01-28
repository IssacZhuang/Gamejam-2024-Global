extends Node2D

@export var camera: Camera2D
@export var relativeScale: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camera == null:
		return
	scale = camera.zoom * relativeScale
	pass
