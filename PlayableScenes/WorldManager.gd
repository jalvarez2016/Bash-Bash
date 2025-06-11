extends Node3D
@export var resetPosition  : Marker3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		body.global_position = resetPosition.global_position
