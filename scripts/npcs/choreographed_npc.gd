extends Node

"""
HOW TO USE

*** For an example of how to use this node, see room_scene.tscn ***

This node is used for moving npcs in specific ways during dialogue
scenes. Here are the stepts you should follow in order to use this node:
- First, add a new stationaryNPC object as a child to the world scene you are
  working on. Make sure that you do not add it as a child to this node, as
  that can create problems with y sort. Add a reference to the stationary npc
  that you want to animate inside the stationary_npc export variable.
  Make sure that you add an AnimatedSprite2D object a child of the stationaryNPC
  and that this is linked to the stationaryNPC through its corrisponding export
  variable.
- Next, add Path2D objects as children of this node. The npc will follow one path
  at a time as they are signaled to do so. The order that the npc follows the paths
  in is determined by the order of the Path2D children.
- Finally, to make the npc follow the next path in the sequence, call 
  move_npc_to_next_path(). You can also hook this function up to specfic
  Dialogic signals by adding signal names to the dialogic_signals_to_progress_to
  list. 
"""

@export var stationary_npc : Node
@export_category("Animation information")
## Should match the corrisponding animation name in the child AnimatedSprite2D node of the stationaryNPC
@export var idle_animation : String
## Should match the corrisponding animation name in the child AnimatedSprite2D node of the stationaryNPC
@export var walk_up_animation : String
## Should match the corrisponding animation name in the child AnimatedSprite2D node of the stationaryNPC
@export var walk_down_animation : String
## Should match the corrisponding animation name in the child AnimatedSprite2D node of the stationaryNPC
@export var walk_right_animation : String
@export_category("Progress")
@export var speed : float = 100
@export var lerp_rate = .01
@export var is_progressing : bool = true
@export var is_ignoring_break_points : bool
@export var dialogic_signals_to_progress_to : Array[String]

var follower : PathFollow2D
var direction = Vector2.ZERO
var paths : Array[Path2D]
var current_path = -1

signal finished_path(num)

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	for child in get_children():
		if(child is Path2D):
			paths.append(child)
	#$Path2D.add_child(follower)
	#set_npc_path(0, false)

func _process(delta):
	if(is_instance_valid(follower)):
		var old_pos = follower.position
		stationary_npc.position = lerp(stationary_npc.position, follower.position, 1 - pow(lerp_rate, delta))
		if(is_progressing):
			follower.progress += delta*speed
			if(follower.progress_ratio == 1):
				finished_path.emit(current_path)
				if(is_ignoring_break_points && current_path < paths.size()):
					move_npc_to_next_path()
				else:
					is_progressing = false
		direction = (follower.position - old_pos)
		switch_npc_animation()
		
func move_npc_to_next_path(set_progress = true):
	set_npc_path(current_path+1, set_progress)

func set_npc_path(path, set_progress = true):
	is_progressing = set_progress
	if(path >= paths.size() || path < 0):
		return
	current_path = path
	if(is_instance_valid(follower)):
		follower.queue_free()
	follower = PathFollow2D.new()
	follower.rotates = false
	follower.loop = false
	paths[current_path].add_child(follower)
	
func switch_npc_animation():
	var angle = direction.normalized().angle()
	var diff = PI/4
	if(direction == Vector2.ZERO):
		stationary_npc.switch_animation(idle_animation)
	elif(angle > -3*PI/4 && angle < -PI/4):
		stationary_npc.switch_animation(walk_up_animation)
	elif(angle > PI/4 && angle < 3*PI/4):
		stationary_npc.switch_animation(walk_down_animation)
	elif(angle > -PI/4 && angle < PI/4):
		stationary_npc.switch_animation(walk_right_animation)
		stationary_npc.face_right(true)
	elif(angle > 3*PI/4 || angle < -3*PI/4):
		stationary_npc.switch_animation(walk_right_animation)
		stationary_npc.face_right(false)

func is_angle_difference_greater(angle1, angle2, diff):
	return abs(angle1 - angle2) < diff

func _on_dialogic_signal(argument:String):
	if(argument in dialogic_signals_to_progress_to):
		move_npc_to_next_path()
		print(current_path)
