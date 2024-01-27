extends RigidBody2D


func _ready():
	body_entered.connect(_on_character_body_entered_wooden_wall)


func check_broke(body):
	if body.is_invincible == true:
		woodenwall_destroy()


func _on_character_body_entered_wooden_wall(body):
	if body.name == "CharacterBoth":
		print("CharacterBoth hit wooden!")
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
	
