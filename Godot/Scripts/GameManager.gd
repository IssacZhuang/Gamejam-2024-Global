extends Node2D

@export var soundManager: Node2D;
@export var characterManager: Node2D;
@export var pointManager: Node2D;

var isGameStart = false



func _ready():
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("game_start"):
		isGameStart = true
		pointManager.start()
		characterManager.start(pointManager.startPositon)

