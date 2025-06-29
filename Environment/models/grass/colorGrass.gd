@tool
extends Node3D
@export var color: StandardMaterial3D

func _ready() -> void:
	var children = get_children()
	children.filter(
		func (node: MeshInstance3D):
			if node is MeshInstance3D:
				node.set_surface_override_material(0, color)
	);
