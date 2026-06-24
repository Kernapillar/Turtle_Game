extends Node
class_name Weapon 

@export var damage: int
@export var attack_speed: float
@export var weapon_name: String
@onready var sprite: Sprite2D = $Sprite2D
var thrown = preload('res://Scenes/projectile.tscn')

func attack(pos, dir): 
	var projectile = thrown.instantiate()
	projectile.setup(pos, dir, damage, sprite.texture, 0.3)
	get_tree().get_first_node_in_group("Game").add_child(projectile)
	
func equip(): 
	pass
