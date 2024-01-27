extends RigidBody2D

var is_active = true

@export_group("Characters Physics Settings")
@export var thrust: Vector2 = Vector2(0, -400)
@export var torque = 700
@export var initial_force: Vector2 = Vector2(3000, -4000)
@export var cooldown_time = 2 #冷却时间,单位秒
@export var invincible_time = 0.5 #冲刺后无敌时间
var cooldown_left = 0
var can_burst: bool
var is_invincible: bool
signal burst

# Called when the node enters the scene tree for the first time.
func _ready():
	can_burst = true
	is_active = true
	body_entered.connect(_on_character_body_entered)
	#sleeping = true
	shoot()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(is_invincible)
	if cooldown_left > 0:
		cooldown_left -= delta
	
	if cooldown_left <= 0:
		can_burst = true
	else:
		can_burst = false
#func _physics_process(delta):
	#if body_entered(node):
		#print(node.name)
func _on_character_body_entered(body):
	print(body.name)
	if body.name == "Floor":
		emit_signal("game_over")
	elif body.name == "Character2":
		return
	else:
		emit_signal("collide_with_barrier")

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
	if can_burst and Input.is_action_just_pressed("player_power_down"):
		#print("player_power_down")
		#state.apply_force(thrust.rotated(rotation))
		state.apply_impulse(thrust.rotated(rotation+1.57))
		cooldown_left = cooldown_time
		burst.emit()
		start_invincible()
	else:
		state.apply_force(Vector2())
	var rotation_direction = 0
	if Input.is_action_pressed("player_rotation_left"):
		#print("player_rotation_left")
		rotation_direction -= 1
	if Input.is_action_pressed("player_rotation_right"):
		#print("player_rotation_right")
		rotation_direction += 1
	state.apply_torque(rotation_direction * torque)
func start_invincible():
	is_invincible = true
	await get_tree().create_timer(1.0).timeout
	is_invincible = false
func on_separate():
	is_active = false

#func start():
	#sleeping = false
