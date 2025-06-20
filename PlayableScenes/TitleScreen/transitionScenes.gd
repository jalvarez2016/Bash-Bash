extends Label3D

@export var titleScreen: Node3D
@export var nextScene: String

func action():
	var nextSceneResource = load(nextScene)
	var newScene: Node3D = nextSceneResource.instantiate()
	get_tree().root.add_child(newScene)
	titleScreen.queue_free()
