extends Node2D

var defenders = preload("res://escenas/defender.tscn")
var defs_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$defenders_placer.global_position = get_global_mouse_position()
	defs_count = $defenders_placer.get_child_count()
	if Global.modo_compra == true:
		if Input.is_action_just_pressed("click"):
			Global.modo_compra = false
func _on_button_pressed():
	if defs_count == 0:
		Global.modo_compra = true
		var defendr = defenders.instantiate()
		$defenders_placer.add_child(defendr)

func _reset():
	$defenders_placer.get_child(0).queue_free()
