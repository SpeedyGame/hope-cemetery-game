extends CanvasLayer

@onready var journal = $journal_gui
@onready var backpack_items = $backpack_buttons
@onready var journal_control = journal.get_node("Control")


func _ready():
	journal.visible = false
	backpack_items.visible = false

func _on_backpack_pressed():
	if journal.visible == true:
		journal.visible = false
		journal_control.hide_canvas()
	if backpack_items.visible == false:
		backpack_items.visible = true
	else:
		backpack_items.visible = false


func _on_quest_button_pressed():
	if journal.visible == false:
		journal.visible = true
	else:
		journal.visible = false
		journal_control.hide_canvas()
