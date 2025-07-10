extends SpringArm3D
@export var mouse_sensetivity := 0.005
@export var active: bool = true
@export var playerBody: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#pass

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion && active:
		rotation.x -= event.relative.y * mouse_sensetivity
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(50))
		
		rotation.y -= event.relative.x * mouse_sensetivity
		rotation.y = wrapf(rotation.y, -PI, PI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("mouse_release"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if !playerBody.isPaused:
			active = false
	elif Input.is_action_just_released("mouse_release"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if !playerBody.isPaused:
			active = true
	if playerBody:
		global_position = playerBody.global_position
