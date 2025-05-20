extends Node3D
@export var playerBody: RigidBody3D
var shieldAttachments: Array[CollisionShape3D] = []

func addToShield(object: CollisionShape3D):
	playerBody.add_child(object)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("attachment"):
		if !body.canAttach:
			return
		var shieldAttachment: Node3D = body.collider
		shieldAttachment.reparent(playerBody, true)
		shieldAttachments.push_back(body.collider)
		body.collider.playerShieldManager = self
		body.collider.isAttached = true
		body.queue_free()
	if body.is_in_group('enemy'):
		playerBody.damage(10)


func _process(_delta: float) -> void:
	if shieldAttachments.size() < 1:
		return
	var updatedShieldAttachments: Array[CollisionShape3D] = []
	shieldAttachments.map(
		func(piece: CollisionShape3D):
			if piece.health > 0:
				updatedShieldAttachments.push_back(piece)
			else:
				piece.queue_free()
	)
	shieldAttachments = updatedShieldAttachments
