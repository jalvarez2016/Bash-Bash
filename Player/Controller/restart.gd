extends Label

@export var player_main: Node3D

func action():
	if player_main.current_level:
		player_main.current_level.reload_current_scene()
	else:
		printerr("No current level assigned to player. Cannot restart level from pause menu")
