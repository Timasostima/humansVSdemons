extends Node2D

var defenders = preload("res://scenes/defender.tscn")
var end_screen = preload("res://scenes/end_menu.tscn")

func _ready():
	pass

func _process(_delta):
	if Global.hearts_remaining <= 0:
		show_end_screen()  # Show results instead of quitting
		return
	
	# Update coin label
	$coin.get_node("coinLabel").text = str(Global.money)
	
	# Move placer to mouse position
	$shop/wanderer/wanderer_placer.global_position = get_global_mouse_position()
	
func _on_button_pressed():
	if !Global.buyer_mode:
		Global.buyer_mode = true
		var defendr = defenders.instantiate()
		$shop/wanderer/wanderer_placer.add_child(defendr)

func _reset_placer():
	if $shop/wanderer/wanderer_placer.get_child_count() > 0:
		$shop/wanderer/wanderer_placer.get_child(0).queue_free()

# Function to show end results screen
func show_end_screen():
	# Disable game interactions
	get_tree().paused = true  
	Global.buyer_mode = false
	Global.placement_check_mode = false
	
	$shop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$DefenderGrid.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Instantiate the end screen UI
	var end_screen_instance = end_screen.instantiate()
	add_child(end_screen_instance)

	end_screen_instance.get_node("results/moneyEarnedNum").text = str(Global.money_earned)
	end_screen_instance.get_node("results/demonsKilledNum").text = str(Global.kills)

# Function to restart the game
func _restart_game():
	get_tree().paused = false  # Resume game
	get_tree().reload_current_scene()  # Restart scene
