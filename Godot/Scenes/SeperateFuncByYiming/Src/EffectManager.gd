extends Node2D


var effect_dict = {}
var cached_effect_node = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	scan_dir("res://Effect", ".tscn")
	scan_node(get_tree().root.get_child(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clean_finished_effect()

func trigger_effect_by_name(node_name):
	# node: node to spawn effect
	# check if node exist in cache
	var node = null
	if cached_effect_node.has(node_name):
		node = cached_effect_node[node_name]
		if node.has_method("Emit"):
			node.Emit()
		else:
			print("Node must have Emit function")
	else:
		print("Node not in cache")
		return 


func trigger_effect_once(target_position: Vector2, target_rotation: float, target_scale: Vector2, target_skew: float, effect_name: String):
	# position: position to spawn effect
	# effect_name: name of effect
	var effect = load(effect_dict[effect_name])
	var effect_instance = effect.instantiate()
	effect_instance.position = target_position
	effect_instance.rotation = target_rotation
	effect_instance.scale = target_scale
	effect_instance.skew = target_skew
	self.add_child(effect_instance)
	# check if node have Emit function
	if effect_instance.has_method("Emit"):
		effect_instance.EmitOnce()
	else:
		assert(false, "Effect node must have Emit function")

func clean_finished_effect():
	# clean all effect that have finished
	for child in self.get_children():
		if child.has_method("is_finished"):
			if child.is_finished():
				child.queue_free()

# recursively scan all node and cache node name if node have Emit function
func scan_node(root_node):
	for child in root_node.get_children():
		if child.has_method("Emit"):
			cached_effect_node[child.name] = child
		if child.get_child_count() > 0:
			scan_node(child)

# check path exist, scan dir from path and add all file end with ext to the array
func scan_dir(path, ext):
	# path: res://path to dir
	# check path exist
	# dir access
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				scan_dir(path + "/" + file_name, ext)
			else:
				if file_name.ends_with(ext):
					# add to array
					effect_dict[file_name.get_basename()] = path + "/" + file_name
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
