extends RigidBody3D
@export var force: float = 10
var targetPosition: Vector3 # is set when enemy initializes

func shoot() -> void:
	print('new bullet spawned')
	var direction = targetPosition - global_position
	apply_central_impulse(direction * force)

func _on_lifespan_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func damage(damageAmount: float):
	print('damaged', damageAmount)
	queue_free()
