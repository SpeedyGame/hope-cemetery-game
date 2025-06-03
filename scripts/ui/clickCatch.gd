extends PanelContainer
@onready var clickCatcher = $".."

#catches clicks off the canvas layer when the game is paused and unpauses the game
func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"../../..".turnbutton()
