extends CanvasLayer

@onready var journal = $journal_gui
@onready var inventory = $Inventory
@onready var backpack_items = $backpack_buttons
@onready var pause = $PauseMenu
@onready var pause_layer = pause.get_node("CanvasLayer")
@onready var journal_control = journal.get_node("Control")
@onready var inventory_control = inventory.get_node("TextureRect")
@onready var quest = journal_control.get_node("quest_gui")
@onready var pause_rect = pause.get_node("ColorRect")
@onready var qbutanim = $backpack_buttons/Control/quest_button/quest_button_animation



func _ready():
	journal.visible = false
	backpack_items.visible = false
	inventory.visible = false
	pause_layer.visible = false
	quest.visible = false 
	journal_control.connect("quest_button_pressed", Callable(self, "_on_quest_journal_button_triggered"))
	

func _process(delta):
	if pause_layer.visible == true:
		$backpack.disabled = true
		for child in $backpack_buttons/Control.get_children():
			if child is BaseButton:
				child.disabled = true
	else: 
		$backpack.disabled = false
		for child in $backpack_buttons/Control.get_children():
			if child is BaseButton:
				child.disabled = false
	
	if journal_control:
		pass
	

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
		inventory.visible = false
		play_book_animation()
		journal.visible = true
	else:
		reverse_book_animation()
		journal.visible = false
		journal_control.hide_canvas()
	


func _on_inventory_button_pressed():
	quest.visible = false
	journal_control.hide_canvas()
	journal.visible = false
	if journal.visible:
		reverse_book_animation()
	
	if inventory.visible == true:
		inventory.visible = false
	else:
		inventory.visible = true

func play_book_animation():
	qbutanim.play("open")
	qbutanim.play("finishopen")

func reverse_book_animation():
	qbutanim.play("close")
	qbutanim.play("finishclose")
func _on_quest_journal_button_triggered():
	qbutanim.play("turnright")
