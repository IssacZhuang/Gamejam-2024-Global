extends Camera2D

var template: PackedScene = load("res://Scenes/end_pointer_prefab/sprite_2d.tscn")
var end_points_node;
var end_points_pointer : Array = [];

var camera : Node2D
var camera_pos: Vector2
var window_size: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_viewport().get_camera_2d()
	end_points_node = get_parent().get_node("Level1/EndPoints").get_children()
	
	for end_point_node in end_points_node:
		var t = template.instantiate()
		t.position = get_screen_center_position() + Vector2(0,500)
		end_points_pointer.append(t)
		add_child(t)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#for end_point in end_points:
		#
	#pass

func _process(_delta):
	camera_pos = camera.position
	window_size = Vector2(1920,1080) * 1 / camera.zoom.x  
	for i in range(end_points_node.size()):
		var end_point = end_points_node[i]
		var end_pointer = end_points_pointer[i]
		if isPointInScreen(end_point.position):
			end_pointer.hide()
		else:
			end_pointer.show()
			var dest_pos = end_point.position
			var direction: Vector2 = dest_pos - camera_pos


			if direction.normalized().abs().aspect() < window_size.aspect():
				# stick to the up/bot
				if direction.normalized().x > 0:
					end_pointer.position.x =  direction.normalized().abs().aspect() * window_size.y / 2
				else:
					end_pointer.position.x = - direction.normalized().abs().aspect() * window_size.y / 2
			
				if direction.normalized().y < 0:
					end_pointer.position.y = -window_size.y / 2
				else:
					end_pointer.position.y = window_size.y / 2

			else:
				# stick to the left/right
				end_pointer.position.x = window_size.x / 2
				if direction.normalized().y > 0:
					end_pointer.position.y = 1 / direction.normalized().abs().aspect() * window_size.x / 2
				else:
					end_pointer.position.y = - 1 / direction.normalized().abs().aspect() * window_size.x / 2
				if direction.normalized().x < 0:
					end_pointer.position.x = -window_size.x / 2
				else:
					end_pointer.position.x = window_size.x / 2

	pass

func isPointInScreen(point:Vector2):

	if point.x < camera_pos.x - window_size.x/2 || point.x > camera_pos.x + window_size.x/2:
		return false
	if point.y < camera_pos.y - window_size.y/2 || point.y > camera_pos.y + window_size.y/2:
		return false
	return true
