extends Node3D
@export var player: Node3D

func _ready() -> void:
	get_tree().set_current_scene(self)

func setup() -> void:
	player.set_camera()
