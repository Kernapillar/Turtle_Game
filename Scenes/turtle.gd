extends CharacterBody2D

var max_speed := 500.0
var roll_speed := 750
var acceleration:= 0.4
var breaking := 0.2
var direction := Vector2(0,1)
var hiding:= false
var rolling:= false
var arms:= {"right": null, "left": null, "back": null}
const arm_scene = preload("res://Scenes/arm.tscn") 
const dagger_scene = preload(("res://Scenes/dagger.tscn"))
const sword_scene = preload(("res://Scenes/sword.tscn"))


func _physics_process(_delta):
	handle_movement_input()
	handle_rotation()
	handle_hide()
	handle_roll()
	handle_test()
	handle_attack()
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
		
func add_arm(arm_slot, type, flipped = false):
	var arm = arm_scene.instantiate()
	arm.setup(arm_slot, type, flipped)
	self.add_child(arm)
	return arm
	
func handle_test(): 
	if Input.is_action_just_pressed("test_button"): 
		if !arms["right"]: 
			var new_arm = add_arm($Right_arm_slot.position, "Wand")
			arms["right"] = new_arm
			var new_weapon = dagger_scene.instantiate()
			arms["right"].equip(new_weapon)
			print("Equipped")
		elif !arms["left"]: 
			var new_arm = add_arm($Left_arm_slot.position, "Sword", true)
			arms["left"] = new_arm
			var new_weapon = sword_scene.instantiate()
			arms["left"].equip(new_weapon)
		else: 
			print("hands full")

func handle_attack(): 
	if Input.is_action_just_pressed("Left_Click"): 
		if arms["right"]: 
			arms["right"].trigger_attack()
		if arms["left"]: 
			arms["left"].trigger_attack(-1)
