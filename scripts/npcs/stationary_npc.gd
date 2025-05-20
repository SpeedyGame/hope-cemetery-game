extends Area2D

@export var animation_player : Node
@export var default_animation : String
@export var timeline : String

var is_touching_player = false
var has_just_been_talked_to = false

func _ready():
	Dialogic.timeline_ended.connect(cooldown)
	if(animation_player is AnimatedSprite2D && default_animation != ""):
		animation_player.play(default_animation)

func _process(delta):
	if(Dialogic.current_timeline == null && is_touching_player && Input.is_action_just_pressed("interact") && !has_just_been_talked_to):
		Dialogic.start(timeline)
		has_just_been_talked_to = true

func switch_animation(new_animation):
	animation_player.play(new_animation)

func face_right(dir):
	animation_player.flip_h = !dir

func _on_area_entered(area):
	is_touching_player = true

func _on_area_exited(area):
	is_touching_player = false

func cooldown():
	if(has_just_been_talked_to):
		$CoolDownTimer.start()

func _on_cool_down_timer_timeout():
	has_just_been_talked_to = false
