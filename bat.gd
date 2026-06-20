extends CharacterBody2D

var speed:= 1
var direction:= Vector2.ZERO
var target = null
var max_health: int
var current_health: int

#func _ready(): 
	#current_health = max_health

func _physics_process(_delta):
	follow()

func follow(): 
	if target: 
		direction = target.position - position
		velocity = direction * speed
		move_and_slide()
	else: 
		return

func _on_aggro_radius_body_entered(body):
	print(body)
	print(get_tree().get_first_node_in_group("Turtle"))
	if body == get_tree().get_first_node_in_group("Turtle"): 
		target = body
	print(target)

func _on_aggro_radius_body_exited(body):
	if body == get_tree().get_first_node_in_group("Turtle"): 
		target = null
		print(target)
