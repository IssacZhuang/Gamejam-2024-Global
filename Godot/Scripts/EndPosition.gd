extends RigidBody2D


enum endpoint_type {
	rotiationEnd,
	powerEnd,
	BothEnd
}

@export var endpointType = endpoint_type.BothEnd
@export var is_active = false
@export var texture: Texture2D
var effectManager: Node2D
var soundManager: Node2D
var is_done = false

func _ready():
	body_entered.connect(_on_character_body_entered_end_point)
	effectManager = get_node("/root/Node2D/EffectManagerNode2D")
	soundManager = get_node("/root/Node2D/SoundManagerNode2D")
	is_done = false
	var children = get_children()
	for c in children:
		if c.name == "Sprite2D":
			c.texture = texture

func _on_character_body_entered_end_point(body):
	print("end")
	if body.name == "CharacterBoth" and endpointType == endpoint_type.BothEnd:
		done_level(body)
	elif body.name == "Character1" and endpointType == endpoint_type.powerEnd:
		done_level(body)
	elif body.name == "Character2" and endpointType == endpoint_type.rotiationEnd:
		done_level(body)
	pass

func done_level(body):
	if not is_done:
		is_done = true




