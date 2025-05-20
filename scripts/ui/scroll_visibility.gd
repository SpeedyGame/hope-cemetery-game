extends PanelContainer
@onready var active_main_scroll = $VBoxContainer/MarginContainer2/PanelContainer/VBoxContainer/ScrollContainer
@onready var active_side_scroll = $VBoxContainer/MarginContainer4/PanelContainer/ScrollContainer
@onready var complete_main_scroll = $VBoxContainer/MarginContainer6/PanelContainer/ScrollContainer
@onready var complete_side_scroll = $VBoxContainer/MarginContainer8/PanelContainer/ScrollContainer
@onready var letter_quest = $VBoxContainer/MarginContainer2/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer/letter_quest
@onready var noquest = $VBoxContainer/MarginContainer2/PanelContainer/noQuests
@onready var letter_popup = $VBoxContainer/MarginContainer2/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer/letter_quest/love_letter_desc


func _process(delta):
	if(!glob_quest.active_main_quests):
		active_main_scroll.visible = false
		noquest.visible = true
	else:
		active_main_scroll.visible = true
		noquest.visible = false
	if(!glob_quest.active_side_quests):
		active_side_scroll.visible = false
	else:
		active_side_scroll.visible = true
	if(!glob_quest.completed_main_quests):
		complete_main_scroll.visible = false
	else:
		complete_main_scroll.visible = true
	if(!glob_quest.completed_side_quests):
		complete_side_scroll.visible = false
	else:
		complete_side_scroll.visible = true
	if(!glob_quest.love_letter_active):
		letter_quest.visible = false 
	else:
		letter_quest.visible = true
		glob_quest.active_main_quests = true
		
		


func _on_letter_quest_pressed():
	pass
