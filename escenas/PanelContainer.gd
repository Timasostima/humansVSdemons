extends PanelContainer

var defenders = preload("res://escenas/defender.tscn")
var construccion = false
var conteo = 0

func _ready():
	self_modulate = "ffffff00"

func _process(_delta):
	var conteo = $Marker2D.get_child_count()
	
	if conteo == 1:
		construccion = false

	elif construccion and Global.comprovacion and Global.modo_compra:
		if Input.is_action_just_pressed("click") and conteo == 0:
			Global.modo_compra = false
			var defender = defenders.instantiate()
			$Marker2D.add_child(defender)
			construccion = false
			
			var level = get_tree().get_nodes_in_group("nivel")
			if level.size() > 0:
				level[0]._reset_placer()

func _on_mouse_entered():
	if conteo ==0 :
		Global.comprovacion = true
		construccion = true
		Global.ubicacion = $Marker2D.global_position
	self_modulate = "ffffff88"


func _on_mouse_exited():
	if conteo ==0 :
		construccion = false
		Global.comprovacion = false
		Global.ubicacion = get_global_mouse_position()
	self_modulate = "ffffff00"

