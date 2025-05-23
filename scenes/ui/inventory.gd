extends Control

var ItemClass = preload("res://scenes/ui/branch.tscn")

@onready var slots_container = $InventoryPanel/InventorySlots
@onready var add_button = $InventoryPanel/InventorySlots/AddBtton

func _ready():
	add_button.pressed.connect(add_item)

func add_item():
	var item = ItemClass.instantiate()
	item.item_clicked.connect(remove_item)

	for i in range(1, 21): 
		var slot_path = "Slot%d" % i
		var slot = $InventoryPanel/InventorySlots.get_node(slot_path)

		if slot.get_child_count() == 0:
			slot.add_child(item)

			
			item.set_anchors_preset(Control.PRESET_FULL_RECT)
			item.offset_left = 0
			item.offset_top = 0
			item.offset_right = 0
			item.offset_bottom = 0
			return  

	print("No empty slots available!")



func remove_item(item_node):
	item_node.queue_free()
