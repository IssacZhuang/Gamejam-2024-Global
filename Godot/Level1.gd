extends Node2D



func start_level():
	var currentStartPoint = $StartPosition.instantiate()
	for endposition in $EndPoints.get_children():
		endposition.instantiate()
	for woodenwall in $WoodenWalls.get_children():
		woodenwall.instantiate()
	for eb in $ExplosionBuckets.get_children():
		eb.instantiate()

func _process(delta):
	pass
