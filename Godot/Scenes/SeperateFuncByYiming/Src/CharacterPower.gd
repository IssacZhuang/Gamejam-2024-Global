extends RigidBody2D

var is_active = false

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)
@export var cooldown_time = 2 #冷却时间,单位秒
@export var invincible_time = 0.5 #冲刺后无敌时间
@export var gunlance: Node2D
var cooldown_left = 0
var can_burst: bool
var is_invincible: bool
signal burst

# Called when the node enters the scene tree for the first time.
func _ready():
	can_burst = true
	is_active = false
	body_entered.connect(on_character_body_entered)
	#sleeping = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		if cooldown_left > 0:
			cooldown_left -= delta
		
		if cooldown_left <= 0:
			if gunlance.state != gunlance.State.Normal:
				gunlance.state = gunlance.State.Normal
			can_burst = true
		else:
			gunlance.state = gunlance.State.Overheat
			can_burst = false

func on_start():
	is_active = false

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
	if is_active and can_burst and Input.is_action_just_pressed("player_power_down"):
		cooldown_left = cooldown_time
		print("player_power_down")
		#state.apply_force(thrust.rotated(rotation))
		state.apply_impulse(thrust.rotated(rotation+1.57))
		burst.emit()
		start_invincible()
	else:
		state.apply_force(Vector2())
func start_invincible():
	is_invincible = true
	await get_tree().create_timer(1.0).timeout
	is_invincible = false
func on_separate():
	is_active = true
func on_character_body_entered(body):

	if body.name == "Floor":
		get_node("/root/Node2D").game_over()
	elif body.name == "Character2":
		return
	else:
		# emit_signal("collide_with_barrier")
		print("collide_with_barrier")
#func start():
	#sleeping = false
