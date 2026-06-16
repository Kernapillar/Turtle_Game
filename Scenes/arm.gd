extends Node2D

var arm_type
var wobble_strength := 5.0
var wobble_speed:= 8.0 
var wobble_phase:= 0.0

var base_rotation: float
func setup(pos, type, flipped):
	print("Setup")
	position = pos
	arm_type = type
	if flipped: 
		$AnimationPlayer.play("Grow_Flipped")
	else: 
		$AnimationPlayer.play("Grow")
	#self.rotation = rotat
	print(self.get_parent())
	
func _process(delta):
	var turtle = get_parent()
	var moving = turtle.velocity.length() > 10.
	if moving:
		var wobble = sin(Time.get_ticks_msec() / 1000.0 * wobble_speed + wobble_phase) * wobble_strength
		rotation_degrees = base_rotation + wobble
	else:
		rotation_degrees = lerp(rotation_degrees, base_rotation, 0.2)
