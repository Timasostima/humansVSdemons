extends Control


func _ready():
	get_tree().paused = false
	$AudioStreamPlayer2D.stream_paused = Global.music_playing

func _process(_delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	pass


func _start_entered():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($menu/startButton/highlight, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($menu/startButton, "scale", Vector2(1.03, 1.06), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _start_exited():
	var tween = create_tween()
	tween.set_parallel(true)	
	tween.tween_property($menu/startButton/highlight, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($menu/startButton, "scale", Vector2(1.0, 1.0), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)


func _github_entered():
	var tween = create_tween()
	tween.tween_property($github/highlight, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _github_exited():
	var tween = create_tween()
	tween.tween_property($github/highlight, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _open_github():
	OS.shell_open("https://github.com/Timasostima")
	pass


func _music_entered():
	var tween = create_tween()
	tween.tween_property($music/highlight, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _music_exited():
	var tween = create_tween()
	tween.tween_property($music/highlight, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _toggle_music():
	if Global.music_playing:
		Global.music_playing = false
		$AudioStreamPlayer2D.stream_paused = true
	else:
		Global.music_playing = true
		$AudioStreamPlayer2D.stream_paused = false
	pass


func _on_title_mouse_entered():
	var tween = create_tween()
	tween.tween_property($menu/title, "modulate", Color(1.0, 0.2, 0.2, 0.7), 0.5)

func _on_title_mouse_exited():
	var tween = create_tween()
	tween.tween_property($menu/title, "modulate", Color("#fbffb6b3"), 0.5)
