extends CharacterBody2D

var speed:= 1
var direction:= Vector2.ZERO
var target = null
var max_health:= 10
var current_health: int
var damage_number_scene = preload('res://Scenes/damage_number.tscn')


func _ready(): 
	current_health = max_health

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
	if body == get_tree().get_first_node_in_group("Turtle"): 
		target = body

func _on_aggro_radius_body_exited(body):
	if body == get_tree().get_first_node_in_group("Turtle"): 
		target = null

func _on_hitbox_area_entered(area):
	if "damage" in area:
		current_health -= area.damage
		var dam_number = damage_number_scene.instantiate()
		dam_number.setup(area.damage, position, false)
		get_tree().get_first_node_in_group("Game").add_child(dam_number)
	if current_health <= 0: 
		queue_free() 
		
