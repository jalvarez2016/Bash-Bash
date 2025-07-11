extends Label
var loadingScene = preload("res://PlayableScenes/LevelSelect/loading.tscn")
@export var player_main: Node3D

func action():
	if player_main.previous_scene:
		var loading_instance = loadingScene.instantiate()
		loading_instance.next_scene = player_main.previous_scene
		get_tree().root.add_child(loading_instance)
		if player_main.current_level:
			player_main.current_level.queue_free()
		else:
			printerr("No current scene to delete on player quit pause menu method")
	else:
		printerr("No previous scene to return to assigned to player")
