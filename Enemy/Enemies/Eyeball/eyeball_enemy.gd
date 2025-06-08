extends Node3D

@export var maxHeight : float = 30.0
@export var floorDetection: RayCast3D
@export var enemyBody: Node3D
@export var enemyDetection : RayCast3D
@export var shootCoolDown : Timer

var bullet: Resource = preload("res://Enemy/Enemies/Eyeball/bullet.tscn")
@export var bulletSpawnPoint: Marker3D

var player: Node3D
var angularAcceleration : float = 2.2
var canShoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	floorDetection.target_position.y = - maxHeight
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attack_logic(delta)
	if floorDetection.is_colliding():
		var floorYPos = floorDetection.get_collision_point().y
		global_position.y = lerp(global_position.y, floorYPos + maxHeight, delta)
		
		return
	global_position.y = global_position.y - delta
	
	

func attack_logic(delta: float):
	if !player:
		return
	var distance: Vector3 = global_position - player.global_position
	var direction: Vector3 = - (global_position - player.global_position).normalized()
	var desiredXAngle = atan2(direction.x, direction.z) + PI
	if abs(distance.distance_to(Vector3.ZERO)) > 5:
		global_position.x = lerp(global_position.x, global_position.x - distance.x , delta)
		global_position.z = lerp(global_position.z, global_position.z - distance.z , delta)
	if direction.z < 0:
		desiredXAngle = desiredXAngle - PI
	var angleToPlayerY: float = lerp_angle(enemyBody.rotation.y, desiredXAngle, delta * angularAcceleration)
	var angleToPlayerX: float = lerp_angle(enemyBody.rotation.x, atan2(direction.y, direction.z) + PI, delta * angularAcceleration)
	enemyBody.rotation.y = angleToPlayerY
	enemyBody.rotation.x = angleToPlayerX
	
	if enemyDetection.is_colliding():
		if !canShoot:
			return
		if enemyDetection.get_collider().is_in_group('player'):
			var targetPos = enemyDetection.get_collision_point()
			var newBullet: RigidBody3D = bullet.instantiate()
			var worldRef:= get_tree().root.get_child(0)
			worldRef.add_child(newBullet)
			newBullet.global_position = bulletSpawnPoint.global_position
			newBullet.global_rotation = enemyBody.global_rotation
			newBullet.targetPosition = targetPos
			newBullet.shoot()
			shootCoolDown.start()
			canShoot = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		player = body
		print('player near')


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		player = null


func _on_shoot_cooldown_timeout() -> void:
	canShoot = true
