extends Control
@onready var pause_canvas = $CanvasLayer
@onready var blur = $ColorRect
func _ready():
	# Start with pause menu hidden
	pause_canvas.visible = false
	blur.visible = false

func turnbutton():
	blur.visible = !blur.visible
	if pause_canvas.visible == false:
		pause_canvas.visible = true
	else:
		pause_canvas.visible = false

func pause():
	turnbutton()

func resume():
	turnbutton()

# === BUTTON SIGNALS ===

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()

func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_save_pressed():
	print("Game saved!")

func _on_return_to_cemetery_pressed():
	resume()
	get_tree().change_scene_to_file("res://cemetery.tscn")

func _on_sound_control_pressed():
	resume()
	get_tree().change_scene_to_file("res://sound_options_menu.tscn")

func _on_quest_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://quest_menu.tscn")

func _on_restart_pressed() -> void:
	pass

func _on_go_to_main_settings_pressed() -> void:
	pass

func _on_go_back_to_cemetery_pressed() -> void:
	pass

func _on_settings_pressed() -> void:
	pass


func _on_texture_button_pressed():
	turnbutton()
