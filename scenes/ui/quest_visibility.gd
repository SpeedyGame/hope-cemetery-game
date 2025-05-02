extends Control
@onready var popup = $PanelContainer/VBoxContainer/MenuButton/popup_person1
@onready var timer = $PanelContainer/VBoxContainer/Timer


func _ready():
	pass


func _on_menu_button_mouse_entered():
	timer.start()



func _on_menu_button_mouse_exited():
	timer.stop()
	popup.hide()


func _on_timer_timeout():
	popup.popup()
