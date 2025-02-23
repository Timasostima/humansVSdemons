extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	pass


func _open_github():
	OS.shell_open("https://github.com/Timasostima")
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

func _music_entered():
	var tween = create_tween()
	tween.tween_property($music/highlight, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _music_exited():
	var tween = create_tween()
	tween.tween_property($music/highlight, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)


func _on_title_mouse_entered():
	print("here")
	var tween = create_tween()
	tween.tween_property($menu/title, "modulate", Color(1.0, 0.2, 0.2, 0.7), 0.5)

func _on_title_mouse_exited():
	var tween = create_tween()
	tween.tween_property($menu/title, "modulate", Color("#fbffb6b3"), 0.5)
