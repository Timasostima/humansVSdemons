extends Control

func _ready():
	var viewport_size = get_viewport_rect().size
	$Node2D.position = viewport_size / 2


func _process(delta):
	pass


