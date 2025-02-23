extends PanelContainer

var defender_scene = preload("res://scenes/defender.tscn")
var can_build = false
var count = 0

func _ready():
	pass
	self_modulate = "ffffff00"

func _process(_delta):
	var count = $Marker2D.get_child_count()
	
	if count == 1:
		can_build = false

	elif can_build and Global.placement_check_mode and Global.buyer_mode:
		if Input.is_action_just_pressed("click") and count == 0:
			Global.buyer_mode = false
			var defender = defender_scene.instantiate()
			defender.get_node("shadow").visible = true
			defender.get_node("hpLabel").visible = true
			$Marker2D.add_child(defender)
			$Marker2D.get_child(0).can_attack = true
			can_build = false
			Global.placement_check_mode = false
			
			var levels = get_tree().get_nodes_in_group("level")
			if levels.size() > 0:
				levels[0]._reset_placer()

func _on_mouse_entered():
	if count == 0:
		Global.placement_check_mode = true
		can_build = true
		Global.location = $Marker2D.global_position
	self_modulate = "ffffff88"

func _on_mouse_exited():
	if count == 0:
		can_build = false
		Global.placement_check_mode = false
		Global.location = get_global_mouse_position()
	self_modulate = "ffffff00"
