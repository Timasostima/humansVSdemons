extends Node2D

var defenders = preload("res://escenas/defender.tscn")
var defs_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$shop/wanderer/wanderer_placer.global_position = get_global_mouse_position()
	
func _on_button_pressed():
	if defs_count == 0:
		Global.buyer_mode = true
		var defendr = defenders.instantiate()
		$shop/wanderer/wanderer_placer.add_child(defendr)

func _reset_placer():
	$shop/wanderer/wanderer_placer.get_child(0).queue_free()
