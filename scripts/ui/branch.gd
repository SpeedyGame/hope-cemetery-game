extends Control

signal item_clicked(control_node: Control)

func _ready():
	$TextureRect.texture = load("res://item_icons/Tree Branch.png")
	$TextureRect.mouse_filter = MOUSE_FILTER_STOP
	$TextureRect.gui_input.connect(on_gui_input)

func on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		item_clicked.emit(self)
