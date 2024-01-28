extends RigidBody2D

var effectManager: Node2D
var soundManager: Node2D

func _ready():
	body_entered.connect(_on_character_body_entered_wooden_wall)
	effectManager = get_node("/root/Node2D/EffectManagerNode2D")
	soundManager = get_node("/root/Node2D/SoundManagerNode2D")


func check_broke(body):
	print(body.name)
	if body.is_invincible == true:
		woodenwall_destroy()


func _on_character_body_entered_wooden_wall(body):
	if body.name == "CharacterBoth":
		print("CharacterBoth hit wooden!")
		soundManager.play_fx("hit_block")
		check_broke(body)
	elif body.name == "Character1":
		print("Character1 hit wooden!")
		check_broke(body)
	elif body.name == "Character2":
		print("Character2 hit wooden!")
		check_broke(body)
	pass


func woodenwall_destroy():
	self.get_parent().queue_free()
	
