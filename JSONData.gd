extends Node

var item_data: Dictionary

func _ready():
	item_data = load_data("res://Data/ItemData.json")

func load_data(file_path: String) -> Dictionary:
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: " + file_path)
		return {}

	var json_string := file.get_as_text()
	var json := JSON.new()
	var parse_result := json.parse(json_string)

	if parse_result != OK:
		push_error("JSON parse error: " + json.get_error_message())
		return {}

	return json.get_data()
