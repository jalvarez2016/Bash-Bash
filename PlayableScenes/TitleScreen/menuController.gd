extends Node3D

@export var menuBtns: Array[Label3D] = []
var currentSelection: int = 0
var selection_color: Color = Color(1.0, 0.482, 0.208)
var default_color : Color = Color(1.0, 1.0, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if menuBtns.size() > 0:
		var currentBtn = menuBtns[currentSelection]
		growBtn(currentBtn)
		currentBtn.modulate = selection_color


func growBtn(btn: Label3D):
	btn.scale = Vector3(1.3, 1.3, 1.3)
	btn.modulate = selection_color


func _process(_delta: float) -> void:
	#cycle through buttons
	if (Input.is_action_just_pressed("left")):
		var currentBtn = menuBtns[currentSelection]
		currentBtn.scale = Vector3.ONE
		currentBtn.modulate = default_color
		if currentSelection == 0:
			currentSelection = menuBtns.size() - 1
		else:
			currentSelection -= 1
		growBtn(menuBtns[currentSelection])
	if (Input.is_action_just_pressed("right")):
		var currentBtn = menuBtns[currentSelection]
		currentBtn.scale = Vector3.ONE
		currentBtn.modulate = default_color
		if currentSelection == menuBtns.size() - 1:
			currentSelection = 0
		else:
			currentSelection += 1
		growBtn(menuBtns[currentSelection])
	
	#use current button selected
	if Input.is_action_just_pressed("ui_accept"):
		var currentBtn = menuBtns[currentSelection]
		currentBtn.action()
