extends Node3D

@export var menuBtns: Array[Label3D] = []
var currentSelection: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if menuBtns.size() > 0:
		print('buttons are there')
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func shrinkBtn(btn: Label3D):
	btn.scale = Vector3(1.3, 1.3, 1.3)


func _process(_delta: float) -> void:

	#cycle through buttons
	if (Input.is_action_just_pressed("left")):
		var currentBtn = menuBtns[currentSelection]
		currentBtn.scale = Vector3.ONE
		if currentSelection == 0:
			currentSelection = menuBtns.size() - 1
		else:
			currentSelection -= 1
		shrinkBtn(menuBtns[currentSelection])
	if (Input.is_action_just_pressed("right")):
		var currentBtn = menuBtns[currentSelection]
		currentBtn.scale = Vector3.ONE
		if currentSelection == menuBtns.size() - 1:
			currentSelection = 0
		else:
			currentSelection += 1
		shrinkBtn(menuBtns[currentSelection])
	
	#use current button selected
	if Input.is_action_just_pressed("ui_accept"):
		var currentBtn = menuBtns[currentSelection]
		print(currentBtn)
		currentBtn.action()
