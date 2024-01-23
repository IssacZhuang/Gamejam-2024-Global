@tool
extends Node2D

@export var is_alive = true
@export var is_separate = true
@export var move_speed = 100
@export var defalut_rotation_speed = 100
@export var is_game_start = true
@export var is_down_well = true
@export var gravity = 10
@export var is_opt = true

var face_direction = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
