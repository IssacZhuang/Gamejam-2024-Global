extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)
@export var torque = 10000

# Torque = radius * F * sin(theta)

func _integrate_forces(state):
	if Input.is_action_just_pressed("player_power_down"):
		print("player_power_down")
		#state.apply_force(thrust.rotated(rotation))
		state.apply_impulse(thrust.rotated(rotation))
	else:
		state.apply_force(Vector2())
	var rotation_direction = 0
	if Input.is_action_pressed("player_rotation_left"):
		print("player_rotation_left")
		rotation_direction += 1
	if Input.is_action_pressed("player_rotation_right"):
		print("player_rotation_right")
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)
