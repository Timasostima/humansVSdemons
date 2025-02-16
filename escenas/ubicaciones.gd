extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_center_container_mouse_entered():
	$"../planta".visible = false


func _on_center_container_focus_exited():
	$"../planta".visible = true


func _on_center_container_mouse_exited():
	$"../planta".visible = true
