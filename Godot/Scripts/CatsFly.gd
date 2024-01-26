extends Node2D


func _ready():
	new_game()

func game_over():
	print("Game Over")
	new_game()


func new_game():
	print("StartNewGame")
	$LevelManager.startLevel(1)
