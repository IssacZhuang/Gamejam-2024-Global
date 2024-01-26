extends RigidBody2D

var is_active = true

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)
@export var torque = 700
@export var initial_force: Vector2 = Vector2(3000, -4000)
# Called when the node enters the scene tree for the first time.
func _ready():
	is_active = true
	#sleeping = true
	shoot()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	apply_impulse(initial_force)
	
func _integrate_forces(state):
	"""
		Behavior:
			Behavor of linked object
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
	var rotation_direction = 0
	if Input.is_action_pressed("player_rotation_left"):
		print("player_rotation_left")
		rotation_direction -= 1
	if Input.is_action_pressed("player_rotation_right"):
		print("player_rotation_right")
		rotation_direction += 1
	state.apply_torque(rotation_direction * torque)
	
func on_separate():
	is_active = false

#func start():
	#sleeping = false
