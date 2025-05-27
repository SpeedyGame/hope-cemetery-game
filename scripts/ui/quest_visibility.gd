extends Control
@onready var quest_gui = $quest_gui
@onready var people_gui = $people_gui

signal quest_button_pressed

func _ready():
	quest_gui.visible = false
	people_gui.visible = false
	

func hide_canvas():
	print("here")
	print(get_parent(), get_parent().visible)
	if not get_parent().visible:
		recurse_turn_off(self)

func recurse_turn_off(node: Node):
	if node is CanvasLayer:
		print(node, node.visible)
		node.visible = false
	for child in node.get_children():
		recurse_turn_off(child)

func _on_people_button_pressed():
	quest_gui.visible = false
	if people_gui.visible == true:
		people_gui.visible = false
	else:
		people_gui.visible = true


func _on_quest_journal_button_pressed():
	emit_signal("quest_button_pressed")
	glob_quest.update_quests()
	$quest_gui/PanelContainer.update_quest_log()
	people_gui.visible = false
	if quest_gui.visible:
		quest_gui.visible = false
	else:
		quest_gui.visible = true
