extends Node2D

var arm_type

func setup(pos, type):
	print("Setup")
	position = pos
	arm_type = type
	$AnimationPlayer.play("Grow")
