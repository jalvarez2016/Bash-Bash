extends Label

@export var ui_main: Control

func action():
	get_tree().reload_current_scene()
	ui_main.queue_free()
