extends Area2D

@export var animation_player : Node
@export var default_animation : String

func _ready():
	if(animation_player is AnimatedSprite2D):
		animation_player.play(default_animation)

func switch_animation(new_animation):
	animation_player.play(new_animation)

func face_right(dir):
	animation_player.flip_h = !dir
