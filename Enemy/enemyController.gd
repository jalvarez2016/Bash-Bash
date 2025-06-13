extends Node3D
@export var maxHealth: float = 100.0
@export var health: float = 100.0
@export var healthBar: TextureProgressBar
@export var attackManager: Node3D
@export var variantOwner: Node3D

func _ready() -> void:
	healthBar.max_value = maxHealth
	healthBar.value = health

func damage(damageAmount: float):
	if health - damageAmount <= 0:
		health = 0
		print('enemy dead')
		owner.queue_free()
		if variantOwner:
			variantOwner.queue_free()
	else:
		health -= damageAmount
	healthBar.value = health


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print('player detected by enemy
		')
		if !attackManager:
			return
		attackManager.action()
