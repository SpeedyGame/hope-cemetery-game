extends Control

var speed = 50

func _process(delta):
	$Path2D/PathFollow2D.progress += delta*speed


func _on_confirm_button_down():
	print(Dialogic.VAR.get('PlayerDescription').get('Name'))
	
