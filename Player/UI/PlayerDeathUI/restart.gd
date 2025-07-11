extends Label

## If you want to remove the ui after restarting, add it here.
## If it's excluded, it won't remove anything
@export var ui_main: Control

func action():
	get_tree().paused = false
	get_tree().reload_current_scene()
	if ui_main:
		ui_main.queue_free()
