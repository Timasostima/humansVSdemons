extends Node2D

var defenders = preload("res://scenes/defender.tscn")
var end_screen = preload("res://scenes/end_menu.tscn")

func _ready():
	pass

func _process(_delta):
	draw_hearts()
	if Global.hearts_remaining <= 0:
		show_end_screen()
		return
	
	$coin.get_node("coinLabel").text = str(Global.money)
	
	$shop/wanderer/wanderer_placer.global_position = get_global_mouse_position()

func draw_hearts():
	match Global.hearts_remaining:
		2:
			$HBoxContainer/heart3.animation = "dead"
		1:
			$HBoxContainer/heart2.animation = "dead"
		0:
			$HBoxContainer/heart1.animation = "dead"

func _on_button_pressed():
	if !Global.buyer_mode:
		Global.buyer_mode = true
		var defendr = defenders.instantiate()
		$shop/wanderer/wanderer_placer.add_child(defendr)

func _reset_placer():
	if $shop/wanderer/wanderer_placer.get_child_count() > 0:
		$shop/wanderer/wanderer_placer.get_child(0).queue_free()

func show_end_screen():
	get_tree().paused = true  
	Global.buyer_mode = false
	Global.placement_check_mode = false
	
	$shop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$DefenderGrid.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var end_screen_instance = end_screen.instantiate()
	add_child(end_screen_instance)

	end_screen_instance.get_node("results/moneyEarnedNum").text = str(Global.money_earned)
	end_screen_instance.get_node("results/demonsKilledNum").text = str(Global.kills)

func _restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
