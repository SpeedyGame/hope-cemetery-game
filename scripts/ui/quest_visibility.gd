extends Control
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
	people_gui.visible = false
	if quest_gui.visible == true:
		quest_gui.visible = false
	else:
		quest_gui.visible = true


func _on_people_button_pressed():
	quest_gui.visible = false
	if people_gui.visible == true:
		people_gui.visible = false
	else:
		people_gui.visible = true
