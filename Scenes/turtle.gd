extends CharacterBody2D

var max_speed := 500.0
var roll_speed := 750
var acceleration:= 0.4
var breaking := 0.2
var direction := Vector2(0,1)
var hiding:= false
var rolling:= false
const arm_scene = preload("res://Scenes/arm.tscn") 


func _physics_process(_delta):
	handle_movement_input()
	handle_rotation()
	handle_hide()
	handle_roll()
	handle_test()
	move_and_slide()
	
func handle_movement_input():
	if rolling or $AnimationPlayer.current_animation in ["Huddle", "Huddle_Reverse"]:
		return 

	direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction.length() > 0: 
		$AnimationPlayer.play("Walk")
		hiding = false
		velocity = velocity.lerp(direction * max_speed, acceleration)
	else: 
		velocity = velocity.lerp(Vector2.ZERO, breaking)	
		if !hiding: 
			$AnimationPlayer.play("Idle")
		else: 
			$AnimationPlayer.play("Idle_Huddle")

func handle_rotation(): 
	if rolling: 
		return
	look_at(get_global_mouse_position())

func handle_hide(): 
	if rolling: 
		return
	if Input.is_action_just_pressed("Space"): 
		if hiding: 
			$AnimationPlayer.play("Huddle_Reverse")
		else: 
			$AnimationPlayer.play("Huddle")
		hiding = !hiding
		
func handle_roll(): 
	if direction == Vector2.ZERO: 
		return
	if Input.is_action_just_pressed("Space"): 
		print("Rolin")
		rolling = true
		velocity = direction * roll_speed
		$AnimationPlayer.play("Roll")
		await $AnimationPlayer.animation_finished
		rolling = false
		
func add_arm(arm_slot, type):
	var arm = arm_scene.instantiate()
	print(arm)
	arm.setup(arm_slot, type)
	self.add_child(arm)
	
func handle_test(): 
	if Input.is_action_just_pressed("test_button"): 
		print("Test")
		add_arm($Right_arm_slot.position, "Wand")
