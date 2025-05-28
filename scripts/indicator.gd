extends CharacterBody2D

@export var target: CharacterBody2D
@export var map_scale: float = 0.1  # Ratio between world and minimap scale

func _process(delta):
	if target:
		# Get position relative to world origin and scale it
		var relative_pos = target.global_position * map_scale
		position = relative_pos
