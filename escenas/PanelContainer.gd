extends PanelContainer

var defenders = preload("res://escenas/defender.tscn")
var construccion = false
var conteo = 0

func _ready():
	pass
	self_modulate = "ffffff00"

func _process(_delta):
	var conteo = $Marker2D.get_child_count()
	
	if conteo == 1:
		construccion = false

	elif construccion and Global.comprobation_mode and Global.buyer_mode:
		if Input.is_action_just_pressed("click") and conteo == 0:
			Global.buyer_mode = false
			var defender = defenders.instantiate()
			$Marker2D.add_child(defender)
			$Marker2D.get_child(0).can_attack = true
			construccion = false
			
			var level = get_tree().get_nodes_in_group("nivel")
			if level.size() > 0:
				level[0]._reset_placer()

func _on_mouse_entered():
	if conteo ==0 :
		Global.comprobation_mode = true
		construccion = true
		Global.ubicacion = $Marker2D.global_position
	self_modulate = "ffffff88"


func _on_mouse_exited():
	if conteo ==0 :
		construccion = false
		Global.comprobation_mode = false
		Global.ubicacion = get_global_mouse_position()
	self_modulate = "ffffff00"

