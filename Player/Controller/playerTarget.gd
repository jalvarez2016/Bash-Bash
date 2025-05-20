extends RayCast3D
@export var debugObject: MeshInstance3D
@export var resetPosition: Marker3D


func _process(_delta: float) -> void:
	if is_colliding():
		debugObject.global_position = get_collision_point()
	else:
		debugObject.global_position = resetPosition.global_position
