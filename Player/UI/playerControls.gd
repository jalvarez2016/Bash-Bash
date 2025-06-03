extends Control

@export var keysContainer : VBoxContainer
var playerKeyUI : Resource = preload("res://Player/UI/actionControl.tscn")


func _ready() -> void:
	var actions = InputMap.get_actions().filter(
		func (action: String) -> bool :
			return !action.begins_with('ui_')
	)
	var formattedActions = actions.map(
		func (action: String):
			return {
				"key":
					InputMap.action_get_events(action)[0].as_text(),
				"eventName": 
					action
			}
	)
	formattedActions.map(
		func (action):
			var controlUI: RichTextLabel = playerKeyUI.instantiate()
			keysContainer.add_child(controlUI)
			controlUI.text = ' ' + action.key + ' - ' + action.eventName + ' '
	)
