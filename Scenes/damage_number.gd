extends Node2D

var crit: bool 
var CRIT_COLOR: Color
var color: Color


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jump_and_fade()

	
func setup(amount: int, pos: Vector2, critical:= false): 
	$Label.text = str(amount)
	print("setup")
	position = pos
	if critical:
		modulate = Color.RED
	
func jump_and_fade():
	var tween = create_tween()
	var start_pos = position
	var target_pos = start_pos + Vector2(randf_range(-30, 30), -60)  # slight random arc

	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.6)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)

	tween.tween_property(self, "modulate:a", 0.0, 0.4)\
		.set_delay(0.2)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished
	queue_free()
