#extends Control
#
#
#var plantas = preload("res://escenas/planta.tscn")
#var modo_compra = false
#var planta
#var ubicacion
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if modo_compra == true:
#		planta.global_position = get_global_mouse_position()
#		if Input.is_action_just_pressed("click"):
#			modo_compra = false
#func _on_button_pressed():
#	modo_compra = true
#	var planta = plantas.instantiate()
#	add_child(planta)
#	planta.global_position = get_global_mouse_position()
