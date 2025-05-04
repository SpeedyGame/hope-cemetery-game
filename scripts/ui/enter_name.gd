extends Control

var speed = 50
signal name_entered

func _process(delta):
	$Path2D/PathFollow2D.progress += delta*speed


func _on_confirm_button_down():
	Dialogic.VAR.get('PlayerDescription').set('Name', $Name.text)
	print(Dialogic.VAR.get('PlayerDescription').get('Name'))
	name_entered.emit()
