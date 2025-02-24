extends Node2D

var wanderers = preload("res://scenes/wanderer.tscn")
var lightning_mages = preload("res://scenes/lightning_mage.tscn")

var end_screen = preload("res://scenes/end_menu.tscn")

func _ready():
	await get_tree().create_timer(3.0).timeout
	$shop/wanderer/coin.get_node("coinLabel").text = "10"
	$shop/lightning_mage/coin.get_node("coinLabel").text = "15"
	pass

func _process(_delta):
	draw_hearts()
	if Global.hearts_remaining <= 0:
		show_end_screen()
		return
	
	$coin.get_node("coinLabel").text = str(Global.money)
	
	$shop/wanderer/placer.global_position = get_global_mouse_position()
	$shop/lightning_mage/placer.global_position = get_global_mouse_position()

func draw_hearts():
	match Global.hearts_remaining:
		2:
			$HBoxContainer/heart3.animation = "dead"
		1:
			$HBoxContainer/heart3.animation = "dead"
			$HBoxContainer/heart2.animation = "dead"
		0:
			$HBoxContainer/heart3.animation = "dead"
			$HBoxContainer/heart2.animation = "dead"
			$HBoxContainer/heart1.animation = "dead"


func _on_button_pressed(price: int, type: String):
	if Global.money < price:
		print(type)
		var tween = create_tween()
		if type == "wanderer":
			var item_box = $shop/wanderer/ItemBox
			tween.tween_property(item_box, "modulate", Color(1, 0.3, 0.3, 1), 0.25)
			tween.tween_property(item_box, "modulate", Color(1, 1, 1, 1), 0.25).set_delay(0.25)
		elif type == "lightning_mage":
			var item_box = $shop/lightning_mage/ItemBox
			tween.tween_property(item_box, "modulate", Color(1, 0.3, 0.3, 1), 0.25)
			tween.tween_property(item_box, "modulate", Color(1, 1, 1, 1), 0.25).set_delay(0.25)
		return
	
	if !Global.buyer_mode:
		Global.money -= price
		Global.buyer_mode = true
		if type == "wanderer":
			var defendr = wanderers.instantiate()
			$shop/wanderer/placer.add_child(defendr)
			Global.def_type = 1
		elif type == "lightning_mage":
			var defendr = lightning_mages.instantiate()
			$shop/lightning_mage/placer.add_child(defendr)
			Global.def_type = 2





func _reset_placer():
	if $shop/wanderer/placer.get_child_count() > 0:
		$shop/wanderer/placer.get_child(0).queue_free()
	if $shop/lightning_mage/placer.get_child_count() > 0:
		$shop/lightning_mage/placer.get_child(0).queue_free()
	Global.def_type = 0

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
