@tool
extends Node2D
class_name ParticleGroupEmit

# GPU particles array
var  particles : Array[GPUParticles2D]
var  trigger_once: bool = false

@export var test_emit: bool = false

func _ready():
	# Get all particles
	for child in get_children():
		if child is GPUParticles2D:
			particles.append(child)
	Stop()
	return

func _process(delta):
	if Engine.is_editor_hint():
		# Code to execute in editor.
		emit_editor()
		pass
	if not Engine.is_editor_hint():
		# Code to execute in game.
		# check_finish()
		pass

func Emit():
	#play 
	for p in particles:
		p.emitting = true
	pass

func EmitOnce():
	trigger_once = true
	#play 
	for p in particles:
		p.emitting = true
	pass

func Stop():
	#stop
	for p in particles:
		p.emitting = false
	pass

func check_finish():
	# check finish after triggerd
	if trigger_once:
		for p in particles:
			if p.emitting:
				return false
		return true
	else: 
		return false

func is_finished():
	return check_finish()

func emit_editor():
	if test_emit:
		Emit()
		test_emit = false
