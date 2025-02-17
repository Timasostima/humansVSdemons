extends Node2D

var demon = preload("res://escenas/demon.tscn")

func _ready():
	var paths = get_children() # Get all Path2D nodes
	var num_zombies = 4
	
	for i in range(num_zombies):
		
		var random_path = paths.pick_random() # Select a random Path2D
		duplicate_zombie(random_path)
		
		await get_tree().create_timer(2.0).timeout

func duplicate_zombie(path_node: Path2D):

	var d2 = demon.instantiate()
	path_node.add_child(d2)

	# Ensure it starts at the beginning of the path
	d2.progress_ratio = 0.0
