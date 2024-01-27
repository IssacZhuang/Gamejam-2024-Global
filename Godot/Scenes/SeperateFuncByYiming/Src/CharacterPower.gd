extends RigidBody2D

var is_active = false

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)
@export var cooldown_time = 5 #冷却时间,单位秒
var cooldown_left = 0
var can_burst: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	can_burst = true
	is_active = false
	#sleeping = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown_left > 0:
		cooldown_left -= delta
	
	if cooldown_left <= 0:
		can_burst = true
	else:
		can_burst = false

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
	if can_burst and Input.is_action_just_pressed("player_power_down"):
		cooldown_left = cooldown_time
		print("player_power_down")
		#state.apply_force(thrust.rotated(rotation))
		state.apply_impulse(thrust.rotated(rotation+1.57))
	else:
		state.apply_force(Vector2())

func on_separate():
	is_active = true
	
#func start():
	#sleeping = false
