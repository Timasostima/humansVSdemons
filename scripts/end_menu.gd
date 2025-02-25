extends Control

func _ready():
	var viewport_size = get_viewport_rect().size
	$results.position = viewport_size / 2
	if !Global.music_playing:
		$AudioStreamPlayer2D.stop()

func _process(_delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	queue_free()
	Global.reset()
