extends RigidBody2D

var is_active = false

@export_group("Characters Physics Settings")
@export var torque = 700

var is_invincible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	is_active = false
	body_entered.connect(on_character_body_entered)
	#sleeping = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	"""
		Behavior:
			Behavior of the character1 object
			(TODO: Yilin Please fill in the behavior of the linked object)
		Args:
			None
		Returns:
			None
	"""
	if is_active:
		var rotation_direction = 0
		if Input.is_action_pressed("player_rotation_left"):
			print("player_rotation_left")
			rotation_direction -= 1
		if Input.is_action_pressed("player_rotation_right"):
			print("player_rotation_right")
			rotation_direction += 1
		state.apply_torque(rotation_direction * torque)

func on_character_body_entered(body):
	print(body.name)
	if body.name == "Floor":
		emit_signal("game_over")
	elif body.name == "Character1":
		return
	else:
		emit_signal("collide_with_barrier")
func on_separate():
	is_active = true

#func start():
	#sleeping = false
