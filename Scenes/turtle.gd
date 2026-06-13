extends CharacterBody2D

var max_speed := 500.0
var acceleration:= 0.4
var breaking := 0.2
var direction := Vector2(0,1)


func _physics_process(delta):
	handle_movement_input()
	move_and_slide()
	
func handle_movement_input(): 
	direction = Input.get_vector("Left", "Right", "Up", "Down") 
	if direction.length() > 0: 
		$AnimationPlayer.play("Walk")
		velocity = velocity.lerp(direction * max_speed, acceleration)
	else: 
		velocity = velocity.lerp(Vector2.ZERO, breaking)	
		$AnimationPlayer.play("Idle")
