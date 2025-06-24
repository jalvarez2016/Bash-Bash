extends Node3D
@export var playerCamera: PhantomCamera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerCamera.set_priority(20)


func start_level(lvl_instance: Node3D) -> void:
	playerCamera.set_priority(0)
	lvl_instance.setup()
	queue_free()
