extends Area2D
class_name Projectile

var speed:= 500 
var direction: Vector2
var damage: int
var velocity:= Vector2.ZERO

func _ready(): 
	$Timer.start()

func _physics_process(delta):
	position += velocity * delta

func setup(start_pos, dir, dam, sprite): 
	position = start_pos
	direction = dir
	damage = dam
	velocity = direction * speed
	$Sprite2D.texture = sprite

func _on_timer_timeout():
	print("projectile done")
	queue_free()
	
