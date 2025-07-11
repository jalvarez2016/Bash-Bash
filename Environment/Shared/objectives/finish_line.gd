extends Node3D
var victory_scene = preload("C:/Users/jason/Dev/bash-and-mash/PlayableScenes/VictoryScreen/level_complete.tscn")
## level_scene is meant to be the next scene you want to load in after this
## scene.
@export var level_scene: String
## level_main is the current level parent node. We want to delete it once 
## the player has reached this finish line
@export var level_main: Node3D
## player reference. Used for checking the elapsed time
@export var player_body: Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		if level_scene:
			var victory_instance = victory_scene.instantiate()
			victory_instance.next_scene = level_scene
			if player_body:
				victory_instance.set_complete_time(player_body.elapsed_time_ref.text)
			else:
				printerr("No player ref set to finish line.")
			get_tree().root.add_child(victory_instance)
			level_main.queue_free()

# TODO: hard code the level_scene to a victory screen where we display how
# long it took the player to finish the level
