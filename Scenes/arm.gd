extends Node2D

var arm_type
var wobble_strength := 5.0
var wobble_speed:= 8.0 
var wobble_phase:= 0.0
var base_rotation: float
var attack_rotation = 0.0
var attacking:= false
var current_weapon: Node2D
var flipped := false

func setup(pos, type, flip):
	wobble_phase = [0, 1, 2, 3].pick_random()
	position = pos
	arm_type = type
	flipped = flip
	base_rotation = rotation_degrees
	if flipped: 
		$AnimationPlayer.play("Grow_Flipped")
	else: 
		$AnimationPlayer.play("Grow")
	
func _process(_delta):
	var turtle = get_parent()
	var moving = turtle.velocity.length() > 10.
	if attacking:
		attack_rotation = lerp(attack_rotation, 0.0, 0.15)
		if abs(attack_rotation) < 0.5:
			attacking = false
	var wobble_offset = 0
	if moving:
		wobble_offset = sin(Time.get_ticks_msec() / 1000.0 * wobble_speed + wobble_phase) * wobble_strength
	else:
		rotation_degrees = lerp(rotation_degrees, base_rotation, 0.2)
	rotation_degrees = lerp(rotation_degrees, base_rotation + wobble_offset + attack_rotation, 0.2)
		
func trigger_attack(mod = 1):
	attack_rotation = 65.0 * mod
	attacking = true
	current_weapon.attack()
	
func equip(wep: Node2D): 
	current_weapon = wep
	var marker = $Hand_marker if !flipped else $Hand_marker_flipped
	current_weapon.position = marker.position
	current_weapon.rotate(2)
	self.add_child(current_weapon)
	
	
