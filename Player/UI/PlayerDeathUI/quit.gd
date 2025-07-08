extends Label
var loadingScene = preload("res://PlayableScenes/LevelSelect/loading.tscn")
@export var level_scene: String
@export var death_ui_controller: Control

func action():
	if level_scene:
		var loading_instance = loadingScene.instantiate()
		loading_instance.next_scene = level_scene
		get_tree().root.add_child(loading_instance)
		death_ui_controller.queue_free()
	else:
		push_error("Cannot quit without next scene")
