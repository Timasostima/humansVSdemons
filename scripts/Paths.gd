extends Node2D

var demon = preload("res://scenes/demon.tscn")
const time_to_create = 5

func _ready():
	create_demons()

func _process(_delta):
	var demons_counter = count_demons()
	if demons_counter == 0:
		Global.wave_number += 1
		create_demons()

func create_demons():
	var cuantity = Global.zombie_counter * Global.wave_number * 0.5
	var time_for_one = (time_to_create + Global.wave_number/3) / cuantity
	
	var paths = get_children()
	for i in range(cuantity):
		var random_path = paths.pick_random()
		duplicate_zombie(random_path)
		
		await get_tree().create_timer(time_for_one).timeout

func count_demons() -> int:
	var demons_counter = 0
	for path in get_children():
		if path is Path2D:
			for child in path.get_children():
				if child is PathFollow2D:
					demons_counter += 1
	return demons_counter

func duplicate_zombie(path_node: Path2D):
	var new_demon = demon.instantiate()
	var new_hp = int(100 * (1.1 ** (Global.wave_number - 1)))
	new_demon.set_full_hp(new_hp)
	path_node.add_child(new_demon)

	new_demon.progress_ratio = 0.0
