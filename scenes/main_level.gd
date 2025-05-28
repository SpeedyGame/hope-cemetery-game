extends Node2D


func _on_area_2d_body_entered(body):
	glob_people.woman = true
	print(glob_people.woman)
