extends Label3D

@export var area_pcam: PhantomCamera3D
var playerCamera

func _on_area_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		print(body)
		playerCamera = body.cameraRotation
		body.cameraRotation = area_pcam
		area_pcam.set_priority(20)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		area_pcam.set_priority(0)
		body.cameraRotation = playerCamera
		playerCamera = null
