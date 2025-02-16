extends PanelContainer

var defenders = preload("res://escenas/defender.tscn")
var construccion = false
var conteo = 0

func _ready():
	self_modulate = "ffffff00"

func _process(_delta):
	conteo = $Marker2D.get_child_count()
	if conteo == 1:
		construccion = false
	if construccion == true :
		if Global.comprovacion == true:
				if Input.is_action_just_pressed("click"):
					if conteo == 0:
						var defendr = defenders.instantiate()
						$Marker2D.add_child(defendr)
						construccion = false
						get_tree().get_nodes_in_group("nivel")[0]._reset()

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

