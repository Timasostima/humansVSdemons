extends Node2D

var demon = preload("res://escenas/demon.tscn")

func _ready():
	var paths = get_children()
	var num_zombies = 10
	
	for i in range(num_zombies):
		
		var random_path = paths.pick_random()
		duplicate_zombie(random_path)
		
		await get_tree().create_timer(0.3).timeout

func duplicate_zombie(path_node: Path2D):
	var new_demon = demon.instantiate()
	path_node.add_child(new_demon)

	new_demon.progress_ratio = 0.0
