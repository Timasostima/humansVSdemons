extends Node

var location = Vector2(0,0)
var placement_check_mode = false
var buyer_mode = false
var zombie_counter = 7
var money = 20
var hearts_remaining = 3


func reset():
	location = Vector2(0,0)
	placement_check_mode = false
	buyer_mode = false
	zombie_counter = 7
	money = 20
	hearts_remaining = 3
