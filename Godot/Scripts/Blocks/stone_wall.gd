extends RigidBody2D

@export var sound_cooldown_time = 0.5 #冷却时间,单位秒
var effectManager: Node2D
var soundManager: Node2D
var cooldown_left = 0
var can_sound: bool

func _ready():
	body_entered.connect(_on_character_body_entered_stonewall_wall)
	effectManager = get_node("/root/Node2D/EffectManagerNode2D")
	soundManager = get_node("/root/Node2D/SoundManagerNode2D")

func _process(delta):
	if cooldown_left > 0:
		cooldown_left -= delta
		can_sound = false
	if cooldown_left <= 0:
		can_sound = true
		cooldown_left = 0

func _on_character_body_entered_stonewall_wall(body):
	if body.name == "CharacterBoth" or body.name == "Character2" or body.name == "Character1":
		# print("CharacterBoth hit wooden!")
		if can_sound:
			soundManager.play_fx("hit_block")
		cooldown_left = sound_cooldown_time
	pass
	
