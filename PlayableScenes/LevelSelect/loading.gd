extends Control
@export var min_timer: Timer
var next_scene: String

func setUp(scene: String) -> void:
	min_timer.start()
	next_scene = scene

func _on_timer_timeout() -> void:
	var loaded_next_scene: Resource = load(next_scene)
	var next_scene_instance = loaded_next_scene.instantiate()
	get_tree().root.add_child(next_scene_instance)
	queue_free()
