extends Area2D

var player_inside = false
var item_collected = false


func _on_body_entered(body):
	print("helloworld")
	if body.name == "player_cat": 
		player_inside = true
		print("inside")

func _on_body_exited(body):
	if body.name == "player_cat":
		player_inside = false
		print("exited")

func _process(_delta):
	if player_inside and not item_collected and Input.is_action_just_pressed("interact"): 
		add_item_to_inventory()
		item_collected = true
		print(item_collected)
		get_parent().queue_free()  

func add_item_to_inventory():
	var inventory = get_tree().get_root().get_node("res://scenes/ui/inventory.tscn")  
	inventory.add_item()

   
