extends Node3D
var loadingScene = preload("res://PlayableScenes/LevelSelect/loading.tscn")
## level_scene is meant to be the next scene you want to load in after this
## scene.
@export var level_scene: String
## level_main is the current level parent node. We want to delete it once 
## the player has reached this finish line
@export var level_main: Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		if level_scene:
			var loading_instance = loadingScene.instantiate()
			loading_instance.next_scene = level_scene
			get_tree().root.add_child(loading_instance)
			level_main.queue_free()

# TODO: hard code the level_scene to a victory screen where we display how
# long it took the player to finish the level
