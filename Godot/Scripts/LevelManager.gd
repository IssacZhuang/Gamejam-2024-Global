extends Node2D

var level1 : PackedScene = load("res://Scenes/Nodes/LevelManager/level_1.tscn")
@export var camera : Camera2D = null
var currentLevel = 0

func _ready():
	currentLevel = 0
	pass
	

func startLevel(level: int):
	if level == 1:
		currentLevel = level
		level1.instantiate()
		camera.position = $Level1/StartPosition.position
		pass
	
