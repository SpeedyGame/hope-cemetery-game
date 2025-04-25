extends Control


func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


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
