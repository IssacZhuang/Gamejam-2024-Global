extends Node2D

signal game_start_signal
signal game_over_signal
signal game_win_signal

@export var charactorManager: Node2D
@export var soundManager: Node2D

var is_done = false

func _ready():
	is_done = false
	charactorManager = get_node("/root/Node2D/CharacteManager")
	soundManager = get_node("/root/Node2D/SoundManagerNode2D")
	new_game()
	
func _process(delta):
	# if action is pressed, then call 
	if Input.is_action_just_pressed("game_start"):
		charactorManager.on_start()
		game_start_signal.emit()


func game_over():
	if not is_done:
		print("Game Over")
		game_over_signal.emit()
		get_tree().reload_current_scene()

func game_win():
	# new_game()
	print("victory")
	is_done = true
	soundManager.stop_music()
	soundManager.play_music("bgm_end")
	game_win_signal.emit()


func new_game():
	print("StartNewGame")
	$LevelManager.startLevel(1)
