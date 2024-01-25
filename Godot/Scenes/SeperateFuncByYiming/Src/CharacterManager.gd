extends Node2D

# export array of AnimatedSprite2D, one for each character
@export_group("Characters Settings")

@export_subgroup("Character1Attributes")
@export var char1AnimatedSprite: AnimatedSprite2D = null
@export var char1CollisionShape2D: CollisionPolygon2D = null

@export_subgroup("Character2Attributes")
@export var char2AnimatedSprite: AnimatedSprite2D = null
@export var char2CollisionShape2D: CollisionPolygon2D = null

@export_subgroup("CharacterNodes")
@export var char1: Node2D = null
@export var char2: Node2D = null
@export var charBoth: Node2D = null

@export_group("Camera Settings")
@export var camera: Node2D = null
@export var move_speed = 1
@export var zoom_speed = 1
@export var default_zoom = 1.5
@export var min_zoom = 0.5
@export var max_zoom = 5
@export var margin = Vector2(400, 200)

# signal for seperating the character
signal separate

var is_separated: bool = false
@onready var screen_size = get_viewport().get_visible_rect().size


# Called when the node enters the scene tree for the first time.
func _ready():
	# move the characters attributes to charBoth node
	
	#hide()
	merge_charactors()
	separate.connect(char1.on_separate)
	separate.connect(char2.on_separate)
	separate.connect(charBoth.on_separate)
	return

func start(pos):
	charBoth.position = pos
	#char1.start()
	#char2.start()
	#show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move amd zoom the camera
	move_camera(delta)
	
	# trigger by input
	if Input.is_action_just_pressed("player_power_separate"):
		on_separate_charactors()
		
		
	#test_move_charactor("RigidBody2D")
	return

"""
--------------------------------------------------
	Process the camera
--------------------------------------------------
"""
func move_camera(delta):
	"""
		Behavior:
			Move the camera with the characters
				1. When the characters are separated:
					Move and zoom the camera with the char1 and char2
				2. When the characters are not separated:
					Move the camera with the charBoth
		Args:
			delta (float): The elapsed time since the previous frame
		Returns:
			None
	"""
	if is_separated:
		var p  = Vector2.ZERO
		p = char1.position + char2.position
		p /= 2
		camera.position = lerp(camera.position, p, move_speed * delta)

		var r = Rect2(camera.position, Vector2.ONE)
		r = r.expand(char1.position)
		r = r.expand(char2.position)
		r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
		print(r)
		var d = max(r.size.x, r.size.y)
		var z
		if r.size.x > r.size.y * screen_size.aspect():
			z = clamp(screen_size.x / r.size.x, min_zoom, max_zoom)
		else:
			z = clamp(screen_size.y / r.size.y , min_zoom, max_zoom)
		print(z)
		camera.zoom = lerp(camera.zoom, Vector2.ONE * z, zoom_speed * delta)

	else:
		var p  = Vector2.ZERO
		p = charBoth.position
		camera.position = lerp(camera.position, p, move_speed * delta)

	return



"""
--------------------------------------------------
	Event for the character separation
--------------------------------------------------
"""

func on_separate_charactors():
	"""
		Behavior:
			On Event: change the parent from charBoth to char1 and char2
			**Once this func called, the trigger 'is_separated' will be set to true**
		Args:
			None
		Returns:
			None
	"""
	if not is_separated:
		is_separated = true
		if check_all_type("CharacterBody2D"):
			separate_charactors_logic("CharacterBody2D")
		elif check_all_type("RigidBody2D"):
			separate_charactors_logic("RigidBody2D")
		else:
			print("Error: The type of the character is not CharacterBody2D or RigidBody2D")
		# trigger seperage signal
		separate.emit()
	return

"""
--------------------------------------------------
	Functions for the character separation
--------------------------------------------------
"""
func separate_charactors_logic(type: String):
	"""
		Behavior:
			separate the characters from each other
		Args:
			type (String): The type of the character, either CharacterBody2D or RigidBody2D
		Returns:
			None
	"""
	# save the velocity and position
	var v = Vector2()
	var v_a = Vector2()
	var p = Vector2()

	# get the velocity and position
	if type == "CharacterBody2D":
		v = charBoth.velocity
		p = charBoth.position
	elif type == "RigidBody2D":
		v = charBoth.get_linear_velocity()
		v_a = charBoth.get_angular_velocity()
		p = charBoth.get_position()
	
	# separate the characters
	separate_charactors()
	# remove the charBoth node
	remove_node(charBoth)
	# change the parent of each characters to the root node
	change_parent(char1, self)
	change_parent(char2, self)

	# maintain the velocity and position
	if type == "CharacterBody2D":
		char1.velocity = v
		char2.velocity = v
		char1.position = p
		char2.position = p
	elif type == "RigidBody2D":
		char1.set_linear_velocity(v)
		char2.set_linear_velocity(v)
		char1.set_angular_velocity(v_a)
		char2.set_angular_velocity(v_a)
		char1.set_position(p)
		char2.set_position(p)
	return

"""
--------------------------------------------------
	utilize func for the character seperation
--------------------------------------------------
"""
func merge_charactors():
	"""
		Behavior:
			Merge the characters into one
		Args:
			None
		Returns:
			None
	"""
	change_char_attribute_parent(char1AnimatedSprite, char1CollisionShape2D, charBoth)
	change_char_attribute_parent(char2AnimatedSprite, char2CollisionShape2D, charBoth)
	return

func separate_charactors():
	"""
		Behavior:
			separate the characters from each other
		Args:
			None
		Returns:
			None
	"""
	change_char_attribute_parent(char1AnimatedSprite, char1CollisionShape2D, char1)
	change_char_attribute_parent(char2AnimatedSprite, char2CollisionShape2D, char2)
	return

func change_char_attribute_parent(charAnimation: AnimatedSprite2D, charCollisionShape: CollisionPolygon2D, targetParent: Node2D):
	"""
		Behavior:
			Remove the character from its parent and add it to the new parent
		Args:
			charNode (Node2D): The character node to change the parent
			charAnimation (AnimatedSprite2D): The character animation to change the parent
			charCollisionShape (CollisionPolygon2D): The character collision shape to change the parent
			parent (Node2D): The new parent
		Returns:    
			None
	"""
	change_parent(charAnimation, targetParent)
	change_parent(charCollisionShape, targetParent)
	return 

func change_parent(node: Node2D, parent: Node2D):
	"""
		Behavior:
			Remove the node from its parent and add it to the new parent
		Args:
			node (Node2D): The node to change the parent
			parent (Node2D): The new parent
		Returns:    
			None
	"""
	node.get_parent().remove_child(node)
	parent.add_child(node)
	return 

func remove_node(node: Node2D):
	"""
		Behavior:
			Remove the node from its parent
		Args:
			node (Node2D): The node to remove
		Returns:
			None
	"""
	node.get_parent().remove_child(node)
	return

func check_all_type(type: String):
	"""
		Behavior:
			Check if all character node is a specific type
		Args:
			types (String): The types to check
		Returns:
			bool: True if the node is the specific type, False if not
	"""
	return check_type(char1, type) and check_type(char2, type) and check_type(charBoth, type)

func check_type(node: Node2D, type: String):
	"""
		Behavior:
			Check if the node is the type
		Args:
			node (Node2D): The node to check
			type (String): The type to check
		Returns:
			bool: True if the node is the type, False if not
	"""
	return node.get_class() == type

"""
--------------------------------------------------
	test function (moving the characters)
--------------------------------------------------
"""
func test_move_charactor(type: String):
	"""
		Behavior:
			test for moving the character, check if the characters are separated or not
				If the characters are separated:
					Move each char1 and char2 separately 
				If the characters are not separated:
					Move the charBoth
		Args:
			type (String): The type of the character, either CharacterBody2D or RigidBody2D
		Returns:
			None
	"""
	# assert the characters are CharacterBody2D
	# move the characters
	if is_separated:
		if type == "CharacterBody2D":
			char1.velocity.x = 10
			#char1.velocity.y = -10
			char2.velocity.x = 10
			#char2.velocity.y = 10
			char1.move_and_slide()
			char2.move_and_slide()
		elif type == "RigidBody2D":
			char1.set_linear_velocity(Vector2(-60, 10))
			char2.set_linear_velocity(Vector2(80, -80))
	else:
		if type == "CharacterBody2D":
			charBoth.velocity.x = 10
			charBoth.move_and_slide()
		elif type == "RigidBody2D":
			charBoth.set_linear_velocity(Vector2(0, 0))
	
	# queue_redraw()
	return

# debug
# func _draw():
#     # draw position of the characters
#     if is_separated:
#         draw_circle(char1.position, 10, Color(1, 0, 0))
#         draw_circle(char2.position, 10, Color(1, 0, 0))
#     else:
#         draw_circle(charBoth.position, 10, Color(1, 0, 0))
