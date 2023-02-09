extends CharacterBody2D

@export @onready var speed: float = 100
@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	var startingPos = Vector2(0,1)
	animationTree.set("parameters/idle/blend_position",startingPos) 

func _physics_process(_delta):
	var inputDir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	updateAnimation(inputDir)
	velocity = inputDir*speed
	
	move_and_slide()
	pickState()


func updateAnimation(moveInput:Vector2):
	if moveInput != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position",moveInput)
		animationTree.set("parameters/walk/blend_position",moveInput)
		
func pickState():
	if velocity != Vector2.ZERO:
		stateMachine.travel("walk")
	else:
		stateMachine.travel("idle")
