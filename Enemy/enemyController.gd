extends Node3D
@export var maxHealth: float = 100.0
@export var health: float = 100.0
@export var healthBar: MeshInstance3D

func damage(damageAmount: float):
	if health - damageAmount <= 0:
		health = 0
		print('enemy dead')
	else:
		health -= damageAmount
	var healthPercentage: float = health/maxHealth
	var healthShader: ShaderMaterial = healthBar.get_surface_override_material(0)
	healthShader.set_shader_parameter('health', healthPercentage)
