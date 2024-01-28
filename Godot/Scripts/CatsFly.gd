extends Node2D

signal game_start_signal
signal game_over_signal

@export var charactorManager: Node2D

func _ready():
	charactorManager = get_node("/root/Node2D/CharacteManager")
	new_game()
	
func _process(delta):
	# if action is pressed, then call 
	if Input.is_action_just_pressed("game_start"):
		charactorManager.on_start()
		game_start_signal.emit()


func game_over():
	print("Game Over")
	game_over_signal.emit()
	get_tree().reload_current_scene()
	# new_game()


func new_game():
	print("StartNewGame")
	$LevelManager.startLevel(1)
