extends Control

@export var options: Array[Label]
var current_selection : int = 0
var selection_color: Color = Color(1.0, 0.482, 0.208)
var default_color : Color = Color(1.0, 1.0, 1.0, 1.0)

func apply_selection_style(option: Label):
	option.label_settings.font_color = selection_color
	option.label_settings.font_size = option.label_settings.font_size * 1.5


func remove_selection_style(option: Label):
	option.label_settings.font_color = default_color
	option.label_settings.font_size = option.label_settings.font_size / 1.5
	

func _ready() -> void:
	var default_option: Label = options[current_selection]
	apply_selection_style(default_option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		remove_selection_style(options[current_selection])
		if current_selection + 1 >= options.size():
			current_selection = 0
		else:
			current_selection += 1
		apply_selection_style(options[current_selection])
	if Input.is_action_just_pressed("ui_down"):
		remove_selection_style(options[current_selection])
		if current_selection - 1 < 0:
			current_selection = options.size() - 1
		else:
			current_selection -= 1
		apply_selection_style(options[current_selection])
	if Input.is_action_just_pressed("ui_accept"):
		options[current_selection].action()
