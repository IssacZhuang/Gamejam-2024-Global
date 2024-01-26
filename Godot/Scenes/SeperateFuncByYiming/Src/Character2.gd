extends RigidBody2D

var is_active = false

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)


# Called when the node enters the scene tree for the first time.
func _ready():
	is_active = false
	#sleeping = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	"""
		Behavior:
			Behavior of the character2 object
			(TODO: Yilin Please fill in the behavior of the linked object)
		Args:
			None
		Returns:
			None
	"""
	if Input.is_action_just_pressed("player_power_down"):
		print("player_power_down")
		#state.apply_force(thrust.rotated(rotation))
		state.apply_impulse(thrust.rotated(rotation+1.57))
	else:
		state.apply_force(Vector2())

func on_separate():
	is_active = true
	
#func start():
	#sleeping = false
