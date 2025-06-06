extends Node3D

@export var maxHeight : float = 30.0
@export var floorDetection: RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	floorDetection.target_position.y = - maxHeight
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if floorDetection.is_colliding():
		var floorYPos = floorDetection.get_collision_point().y
		global_position.y = lerp(global_position.y, floorYPos + maxHeight, delta)
		return
	global_position.y = global_position.y - delta
	pass
