extends Node2D

@export var soundManager: Node2D;



@export var pointManager: Node2D;

signal signal_start

var isGameStart = false



func _ready():
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("game_start"):
		signal_start.emit()
	pass


