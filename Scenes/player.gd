extends CharacterBody2D

var direction:= Vector2(3, 4)
var speed = 40 


func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()
