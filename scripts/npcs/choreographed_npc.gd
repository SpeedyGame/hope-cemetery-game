extends Node

@export var stationary_npc : Node
@export var speed : float = 100
@export var lerp_rate = .01
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
