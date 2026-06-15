extends Node2D

var arm_type

func setup(pos, type, flipped, rotation):
	print("Setup")
	position = pos
	arm_type = type
	if flipped: 
		$Sprite2D.flip_v
		print("Flipped arm")
	self.rotation = rotation
	$AnimationPlayer.play("Grow")
