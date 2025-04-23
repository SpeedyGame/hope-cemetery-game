extends Control

@onready var quest = $Panel/VBoxContainer/quest_button
@onready var quest_gui = $quest_gui
@onready var people_gui = $people_gui

func _ready():
	quest_gui.visible = false
	people_gui.visible = false

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
	people_gui.visible = false


func _on_people_button_pressed():
	if people_gui.visible == false:
		people_gui.visible = true
	else:
		people_gui.visible = false
	quest_gui.visible = false
