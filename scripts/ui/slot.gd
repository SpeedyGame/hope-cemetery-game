extends Panel

var ItemClass = preload("res://scenes/ui/item.tscn")
var item = null
#grabs an item to put in a slot
func _ready():
	if randi() % 2 == 0:
		item = ItemClass.instantiate()
		add_child(item)
