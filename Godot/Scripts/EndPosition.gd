extends Area2D


enum endpoint_type {
	rotiationEnd,
	powerEnd,
	BothEnd
}

@export var endpointType = endpoint_type.BothEnd
@export var is_active = false
@export var is_done = false

func _process(delta):
	pass
