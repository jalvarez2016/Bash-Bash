extends RigidBody3D
@export var healthManager: Node3D
@export var spring_arm: SpringArm3D
@export var playerMain: Node3D
@export var sprintMultiplier: float
@export var maxCharge: float = 80.0
@export var chargeUI: ProgressBar
@export var launchTarget: Marker3D
@export var shieldController: Node3D

var angular_acceleration: float = 2
var chargeAmount: float = 0.0
var playerStates = {
	"MOVING" : "moving",
	"CHARGING": "charging",
}
var state: String = playerStates.MOVING
var speed: float = 10
var strength: int = 5

func _process(delta: float) -> void:
	movement(delta)
	launch(delta)
	pass

func movement(_delta: float) -> void:
	if state != playerStates.MOVING:
		return
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_direction : Vector3 = (playerMain.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	var rotationDirection = (angular_acceleration * move_direction * speed * .1).rotated(Vector3.UP, 90)
	if move_direction:
		if Input.is_action_pressed("sprint"):
			angular_velocity = rotationDirection * 2
		else:
			angular_velocity = rotationDirection
	else:
		constant_force = Vector3.ZERO
		angular_velocity = Vector3.ZERO
	if Input.is_action_just_pressed("jump"):
		print('trying to jump')


func launch(delta: float) -> void:
	if Input.is_action_just_pressed("launch charge"):
		state = playerStates.CHARGING
		chargeUI.visible = true
		constant_force = Vector3(0, 0, 0)
		freeze = true
	elif Input.is_action_just_released("launch charge"):
		freeze = false
		var launchDirection = (launchTarget.global_position - global_position).normalized()
		apply_central_impulse(launchDirection * chargeAmount)
		
		state = playerStates.MOVING
		chargeAmount = 0.0
		chargeUI.visible = false
	if state != playerStates.CHARGING:
		return
		
	chargeAmount = lerp(chargeAmount, maxCharge, 1.75 * delta)
	chargeUI.value = chargeAmount


func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("wall"):
		#linear_velocity = Vector3(-linear_velocity.x, linear_velocity.y, -linear_velocity.z)
		pass
	if body.is_in_group("enemy"):
		var attackSpeed = abs(linear_velocity.distance_to(Vector3.ZERO))
		if attackSpeed >= 3:
			var playerAttackDamage = attackSpeed + strength
			body.damage(playerAttackDamage)
			toggleShieldAttachments(speed, true)
		#if body.isAttacking:
			#print('hit by enemy')
	else:
		toggleShieldAttachments(0.0, false)

func toggleShieldAttachments(attackSpeed: float, setActive: bool) -> void:
	if shieldController.shieldAttachments.size() < 1:
		return
	shieldController.shieldAttachments.map(
		func(piece: CollisionShape3D): 
			if !piece.is_inside_tree():
				return
			piece.isAttacking = setActive
			if piece.isAttacking && attackSpeed >= 3:
				piece.damageAmount = attackSpeed * 3
			else:
				piece.damageAmount = 0.0
	)


func damage(damageAmount: float):
	healthManager.damage(damageAmount)
