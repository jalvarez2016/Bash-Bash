extends Node3D
@export var item: String
@export var maxAmount: int = 100
@export var areaRange: int = 50

func _ready() -> void:
	var amount: int = 0
	while amount < maxAmount:
		var loadedItem: RigidBody3D = load(item).instantiate()
		add_child(loadedItem)
		var rng = RandomNumberGenerator.new()
		loadedItem.global_position.x += rng.randi_range(-areaRange, areaRange)
		loadedItem.global_position.z += rng.randi_range(-areaRange, areaRange)
		amount += 1
