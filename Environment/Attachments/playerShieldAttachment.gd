extends CollisionShape3D
@export var health: float = 100.0
var playerShieldManager: Node3D
var isAttachment: bool = true
var isAttached: bool = false
var isAttacking: bool = false
var damageAmount: float = 0.0

func damage():
	health -= damageAmount
	print('shield piece damaged: ', health)
	#if health <= 0:
		#queue_free()
	#pass


func _on_area_3d_body_shape_entered(_body_rid: RID, body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("enemy") && isAttacking:
		damage()
		damageAmount = 0.0
	elif body.is_in_group("attachment"):
		if !body.canAttach || !isAttached:
			return
		var shieldAttachment: Node3D = body.collider
		shieldAttachment.reparent(playerShieldManager.playerBody, true)
		playerShieldManager.shieldAttachments.push_back(body.collider)
		body.queue_free()
		
