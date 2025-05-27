extends Control

var ItemClass = preload("res://scenes/ui/branch.tscn")
var first: bool = true
var removed: bool = false
var item_array = []

@onready var slots_container = $InventoryPanel/InventorySlots
#@onready var add_button = $InventoryPanel/InventorySlots/AddBtton

func _ready():
	
	InventoryManager.inventory = self
	
func _process(delta: float):
	if InventoryManager.item_collected and first:
		add_item()
		
	if InventoryManager.item_used and !removed:
		remove_item(item_array[0])
		
		
func add_item():
	first =false
	var item = ItemClass.instantiate()
	item_array.append(item)
	
	#item.item_clicked.connect(remove_item)

	for i in range(1, 21): 
		var slot_path = "Slot%d" % i
		var slot = $InventoryPanel/InventorySlots.get_node(slot_path)

		if slot.get_child_count() == 0:
			slot.add_child(item)
			print("item added")
			item.set_anchors_preset(Control.PRESET_FULL_RECT)
			item.offset_left = 0
			item.offset_top = 0
			item.offset_right = 0
			item.offset_bottom = 0
			return  

	print("No empty slots available!")



func remove_item(item_node):
	item_node.queue_free()
	item_array.remove(0)
