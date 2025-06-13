extends RigidBody3D
@export var minMassReq : float = 0.5 
@export var collider: CollisionShape3D
@export var canAttach: bool = true
@export var shieldPart: CollisionShape3D

func _ready() -> void:
	shieldPart.mass = mass

func setMass(newMass: float) -> void:
	mass = newMass
	shieldPart.mass = newMass
