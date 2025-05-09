extends CanvasLayer

@onready var journal = $journal_gui
@onready var inventory = $Inventory
@onready var backpack_items = $backpack_buttons
@onready var pause = $"../PauseMenu"
@onready var pause_layer = pause.get_node("CanvasLayer")
@onready var journal_control = journal.get_node("Control")
@onready var inventory_control = inventory.get_node("Control")



func _ready():
	journal.visible = false
	backpack_items.visible = false
	inventory.visible = false
	pause_layer.visible = false

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

func _on_backpack_pressed():
	if journal.visible == true:
		journal.visible = false
		journal_control.hide_canvas()
	if backpack_items.visible == false:
		backpack_items.visible = true
	else:
		backpack_items.visible = false


func _on_quest_button_pressed():
	if pause_layer.visible == false:
		if journal.visible == false:
			journal.visible = true
		else:
			journal.visible = false
			journal_control.hide_canvas()


func _on_inventory_button_pressed():
	if pause_layer.visible == false:
		if inventory.visible == true:
			inventory.visible = false
			inventory_control.hide_canvas()
		if journal.visible == true:
			journal_control.hide_canvas()
			journal.visible = false
		#if backpack_items.visible == false:
			#backpack_items.visible = true
		#else:
			#backpack_items.visible = false


	
	
