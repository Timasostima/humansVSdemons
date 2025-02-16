#extends TileMap
#
#
#
#func _process(delta):
#	if $".".get_child_count() == 1:
#		$planta.global_position = get_global_mouse_position()
#		if Input.is_action_just_pressed("ui_accept"):
#			var posicion = local_to_map(get_global_mouse_position())
#			set_cell(0,Vector2(posicion),0,Vector2(0,0),0)
#			$planta.queue_free()
#
#
#
