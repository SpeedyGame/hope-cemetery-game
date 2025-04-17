extends Control

@onready var quest = $Panel/VBoxContainer/quest_button
@onready var quest_gui = $quest_gui

func _ready():
	quest_gui.visible = false
	print("here")

func hide_canvas():
	if not get_parent().visible:
		recurse_turn_off(self)

func recurse_turn_off(node: Node):
	if node is CanvasLayer:
		node.visible = false
	for child in node.get_children():
		recurse_turn_off(child)

func _on_quest_button_pressed():
	if quest_gui.visible == false:
		quest_gui.visible = true
	else:
		quest_gui.visible = false
