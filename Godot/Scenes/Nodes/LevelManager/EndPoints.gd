extends Node2D

var is_done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	done_level()

func done_level():
	if scan_all_children_is_done():
		is_done = true
		get_node("/root/Node2D").game_win()


func scan_all_children_is_done():
	for child in get_children():
		if child.is_done == false:
			return false
	return true
