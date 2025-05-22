extends Area2D

@export var animation_player : Node
@export var default_animation : String
@export var timeline : String
@export_category("Immediate Interaction")
## If true, this npc will start a timeline as soon as the player hits the interaction area
@export var interact_immediately : bool
## If the player enters this area, the timeline specified will start
@export var immediate_interaction_area : Area2D
## Dialogue timeline to play when player enters area
@export var immediate_timeline : String

var is_touching_player = false
var has_just_been_talked_to = false
var already_had_immediate_encounter = false

func _ready():
	Dialogic.timeline_ended.connect(cooldown)
	if(animation_player is AnimatedSprite2D && default_animation != ""):
		animation_player.play(default_animation)
	if(interact_immediately && immediate_timeline != "" && is_instance_valid(immediate_interaction_area)):
		immediate_interaction_area.set_collision_mask_value(2, true)
		immediate_interaction_area.area_entered.connect(play_dialogue)
	
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

func play_dialogue(area):
	if(!already_had_immediate_encounter):
		already_had_immediate_encounter = true
		Dialogic.start(immediate_timeline)
