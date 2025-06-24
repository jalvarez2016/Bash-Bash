extends Node3D
@export var player_camera : PhantomCamera3D

func set_camera() -> void:
	player_camera.set_priority(20)
