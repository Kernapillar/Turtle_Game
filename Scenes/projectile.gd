extends Area2D
class_name Projectile

var speed:= 500 
var direction: Vector2
var damage: int
var velocity:= Vector2.ZERO
var rotate_speed

func _ready(): 
	$Timer.start()

func _physics_process(delta):
	position += velocity * delta
	rotate(rotate_speed)

func setup(start_pos, dir, dam, sprite, spin): 
	position = start_pos
	direction = dir
	damage = dam
	velocity = direction * speed
	$Sprite2D.texture = sprite
	rotate_speed = spin

func _on_timer_timeout():
	queue_free()
	
