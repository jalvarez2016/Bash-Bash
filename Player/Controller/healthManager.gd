extends Node3D
@export var healthBar: ProgressBar
@export var playerMain: RigidBody3D

func damage(damageAmount: float):
	if healthBar.value - damageAmount > 0:
		healthBar.value -= damageAmount
		print(healthBar.value)
	else:
		healthBar.value = 0
		playerMain.isAlive = false
		print('player dead')
