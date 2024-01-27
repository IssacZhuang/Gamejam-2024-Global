@tool
extends Node2D
class_name  Gunlance

enum State {
	Normal,
	Overheat
}

@export var state: State :
	set(value):
		state = value
		_setState()

@export var bloomEffect: Node2D

func _ready():
	
	pass


func _setState():
	match state:
		State.Normal:
		#not null
			if bloomEffect != null:
				bloomEffect.hide()
			
		State.Overheat:
			if bloomEffect != null:
				bloomEffect.show()
		_:
			pass
