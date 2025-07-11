extends Control
@export var time_elapsed_label: Label

var next_scene: String

func set_complete_time(time_elapsed: String) -> void:
	time_elapsed_label.text = time_elapsed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if !next_scene:
			printerr('No next scene assigned to level complete')
			return 
		var loaded_next_scene: PackedScene = load(next_scene)
		var next_scene_instance = loaded_next_scene.instantiate()
		get_tree().root.add_child(next_scene_instance)
		queue_free()
