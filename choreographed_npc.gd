extends Node2D

@export var stationary_npc : Node
@export var speed : float = 100
@export var idle_animation : String
@export var walk_up_animation : String
@export var walk_down_animation : String
@export var walk_right_animation : String
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
	if(stationary_npc in get_children()):
		remove_child(stationary_npc)
	current_path = path
	if(is_instance_valid(follower) and stationary_npc in follower.get_children()):
		follower.remove_child(stationary_npc)
		follower.queue_free()
	follower = PathFollow2D.new()
	follower.rotates = false
	follower.loop = false
	follower.add_child(stationary_npc)
	paths[current_path].add_child(follower)
	
func move_npc_to_follower():
	remove_child(stationary_npc)
	follower.add_child(stationary_npc)
	
func switch_npc_animation():
	var angle = direction.normalized().angle()
	if(direction == Vector2.ZERO):
		stationary_npc.switch_animation(idle_animation)
	elif(is_angle_difference_greater(angle, -PI/2, PI/4)):
		stationary_npc.switch_animation(walk_up_animation)
	elif(is_angle_difference_greater(angle, PI/2, PI/4)):
		stationary_npc.switch_animation(walk_down_animation)
	elif(is_angle_difference_greater(angle, -PI, PI/4)):
		stationary_npc.switch_animation(walk_right_animation)
		stationary_npc.face_right(false)
	else:
		stationary_npc.switch_animation(walk_right_animation)
		stationary_npc.face_right(true)

func is_angle_difference_greater(angle1, angle2, diff):
	return abs(angle1 - angle2) < diff

func _on_dialogic_signal(argument:String):
	if(argument in dialogic_signals_to_progress_to):
		move_npc_to_next_path()
		print(current_path)
