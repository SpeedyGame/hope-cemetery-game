extends Control

@export var target: CharacterBody2D
@export var map_scale: float = 0.09
@export var minimap_center: Vector2 = Vector2(154, 21)

func _process(delta):
	if target:
		position = minimap_center + target.global_position * map_scale
