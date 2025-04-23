extends CanvasLayer

@onready var person1 = $PanelContainer/VBoxContainer/MenuButton
@onready var pop_per1 = $PanelContainer/VBoxContainer/MenuButton/popup_person1



func _on_menu_button_toggled(toggled_on):
	pop_per1.popup()
	var pos1 = person1.get_global_position() + Vector2(0, person1.size.y)
	pop_per1.set_position(pos1)
	



func _on_close_pressed():
	pop_per1.hide()
