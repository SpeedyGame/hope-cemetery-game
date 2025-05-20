extends CharacterBody2D

@export var move_speed: float = 100
@export var startDir: Vector2 = Vector2(0,1)
@onready var animTree: AnimationTree = $AnimationTree
@onready var stateMachine: AnimationNodeStateMachinePlayback = animTree["parameters/playback"]
@onready var sprite = $Sprite2D


func _ready():
	update_animation_parameters(startDir)


func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
		
	velocity = input_direction * move_speed
	pick_new_state()
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if(move_input.x < 0):
		sprite.flip_h = true
	elif(move_input.x > 0):
		sprite.flip_h = false
	if(move_input != Vector2.ZERO):
		animTree.set("parameters/Walk/blend_position", move_input)
		animTree.set("parameters/Idle/blend_position", move_input)
	else:
		animTree.set("parameters/Walk/blend_position", Vector2.ZERO)
		animTree.set("parameters/Idle/blend_position", Vector2.ZERO)

func pick_new_state():
	if (!velocity.is_equal_approx(Vector2.ZERO)):
		stateMachine.travel("Walk")
	else:
		stateMachine.travel("Idle")
