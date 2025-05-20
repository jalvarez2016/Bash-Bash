extends Node3D
@export var healthBar: ProgressBar

func damage(damageAmount: float):
	if healthBar.value - damageAmount > 0:
		healthBar.value -= damageAmount
		print(healthBar.value)
	else:
		healthBar.value = 0
		print('player dead')
