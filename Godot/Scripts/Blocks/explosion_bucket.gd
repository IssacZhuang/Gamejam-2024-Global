extends RigidBody2D

var effectManager: Node2D

func _ready():
	body_entered.connect(_on_character_body_entered_explosion_bucket)
	effectManager = get_node("/root/Node2D/EffectManagerNode2D")

func check_broke(body):
	woodenwall_destroy()


func _on_character_body_entered_explosion_bucket(body):
	print(body.name)
	if body.name == "CharacterBoth":
		# seperate player Both
		body.get_parent().on_separate_charactors()
		effectManager.trigger_effect_once(self.global_position, 0, Vector2(1,1), 0, "Explosion1")
		
		check_broke(body)
	elif body.name == "Character1":
		print("Character1 hit wooden!")
		check_broke(body)
	elif body.name == "Character2":
		print("Character2 hit wooden!")
		check_broke(body)
	pass


func woodenwall_destroy():
	queue_free()
	
