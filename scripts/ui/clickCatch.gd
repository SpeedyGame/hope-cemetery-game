extends PanelContainer
@onready var clickCatcher = $".."


func _on_control_gui_input(event):
	# If clicked anywhere outside menu, close it
	if event is InputEventMouseButton and event.pressed:
		$"../../..".turnbutton()
