extends Node3D
@export var player_camera : PhantomCamera3D
## absolute file path to previous scene if player quits current scene.
## Defaults to the level select screen.
@export var previous_scene: String = "C:/Users/jason/Dev/bash-and-mash/PlayableScenes/LevelSelect/level_select.tscn"
## The current level root node that will be removed if the player quits the level.
## This is also used to know which level to reload on restart in the pause menu
@export var current_level: Node3D

func set_camera() -> void:
	player_camera.set_priority(20)
