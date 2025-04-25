extends Control


func hide_canvas():
	if not get_parent().visible:
		recurse_turn_off(self)

func recurse_turn_off(node: Node):
	if node is CanvasLayer:
		node.visible = false
	for child in node.get_children():
		recurse_turn_off(child)
