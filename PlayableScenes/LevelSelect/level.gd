extends MeshInstance3D
var loadingScene = preload("res://PlayableScenes/LevelSelect/loading.tscn")
@export var level_select_owner: Node3D
@export var level_scene: String
@export var level_label: Label

func _on_area_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		level_label.visible = true


func _on_area_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		level_label.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if level_label.visible and level_scene:
			var loading_instance = loadingScene.instantiate()
			loading_instance.next_scene = level_scene
			get_tree().root.add_child(loading_instance)
			level_select_owner.queue_free()
