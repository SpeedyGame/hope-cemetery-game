extends Control

var ItemClass = preload("res://scenes/ui/branch.tscn")

@onready var slots_container = $InventoryPanel/InventorySlots
@onready var add_button = $InventoryPanel/InventorySlots/AddBtton

func _ready():
	add_button.pressed.connect(add_item)

func add_item():
		# Create a new item instance and connect its click signal
	var item = ItemClass.instantiate()
	item.item_clicked.connect(remove_item)
# Loop through inventory slots to find the first empty one
	for i in range(1, 21): 
		var slot_path = "Slot%d" % i
		var slot = $InventoryPanel/InventorySlots.get_node(slot_path)
		# Place item in the first available empty slot
		if slot.get_child_count() == 0:
			slot.add_child(item)

			
			item.set_anchors_preset(Control.PRESET_FULL_RECT)
			item.offset_left = 0
			item.offset_top = 0
			item.offset_right = 0
			item.offset_bottom = 0
			return  
	# Show message if inventory is full
	print("No empty slots available!")


# Removes an item when it's clicked
func remove_item(item_node):
	item_node.queue_free()
