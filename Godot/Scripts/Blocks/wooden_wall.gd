extends RigidBody2D

@export var sound_cooldown_time = 1.0 #冷却时间,单位秒
var effectManager: Node2D
var soundManager: Node2D
var cooldown_left = 0
var can_sound: bool

func _ready():
	body_entered.connect(_on_character_body_entered_wooden_wall)
	effectManager = get_node("/root/Node2D/EffectManagerNode2D")
	soundManager = get_node("/root/Node2D/SoundManagerNode2D")

func _process(delta):
	if cooldown_left > 0:
		cooldown_left -= delta
		if cooldown_left <= 0:
			can_sound = true
			cooldown_left = 0
		else:
			can_sound = false

func check_broke(body):
	if body.is_invincible == true:
		woodenwall_destroy()


func _on_character_body_entered_wooden_wall(body):
	if body.name == "CharacterBoth" or body.name == "Character2" or body.name == "Character1":
		# print("CharacterBoth hit wooden!")
		cooldown_left = cooldown_time
		if can_sound == true:
			soundManager.play_fx("hit_block")
		check_broke(body)
	pass


func woodenwall_destroy():
	self.get_parent().queue_free()
	
