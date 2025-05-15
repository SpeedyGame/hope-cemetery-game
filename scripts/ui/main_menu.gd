extends Control
@onready var settings = $settings
@onready var credits = $credits
@onready var stats = $stats
@onready var main_menu = $VBoxContainer

func _ready():
	settings.visible = false
	credits.visible = false
	stats.visible = false
	main_menu.visible = true
func _on_newgame_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

#func _on_settings_popup_pressed() -> void:
	#var settings = load("").instance()
	#get_tree().change_scene.add_child(settings)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_popup_pressed() -> void:
	settings.visible = true
	main_menu.visible = false

func _on_credits_button_pressed() -> void:
	credits.visible = true
	main_menu.visible = false
	
func _on_stats_pressed() -> void:
	stats.visible = true 
	main_menu.visible = false

func _on_back_pressed() -> void:
	settings.visible = false
	main_menu.visible = true

func _on_back_2_pressed() -> void:
	credits.visible = false
	main_menu.visible = true
	
func _on_back_3_pressed() -> void:
	stats.visible = false
	main_menu.visible = true

func _on_progress_pressed() -> void:
	stats.visible = false
	main_menu.visible = false
	

func _on_achievements_pressed() -> void:
	pass # Replace with function body.


func _on_time_spent_pressed() -> void:
	pass # Replace with function body.


func _on_days_pressed() -> void:
	pass # Replace with function body.
