extends Node2D

var defenders = preload("res://scenes/defender.tscn")
var defs_count = 0

func _ready():
	pass

func _process(_delta):
	$shop/wanderer/wanderer_placer.global_position = get_global_mouse_position()
	
func _on_button_pressed():
	if defs_count == 0:
		Global.buyer_mode = true
		var defendr = defenders.instantiate()
		$shop/wanderer/wanderer_placer.add_child(defendr)

func _reset_placer():
	$shop/wanderer/wanderer_placer.get_child(0).queue_free()
