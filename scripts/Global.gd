extends Node

var location = Vector2(0,0)
var placement_check_mode = false
var buyer_mode = false
var zombie_counter = 6
var wave_number = 1
var money = 35
var money_earned = 0
var kills = 0
var def_type = 0

var hearts_remaining = 3

func kill(demons, amount):
	kills += demons
	money += amount
	money_earned += amount

func reset():
	location = Vector2(0,0)
	placement_check_mode = false
	buyer_mode = false
	zombie_counter = 7
	money = 20
	hearts_remaining = 3
	money_earned = 0
	def_type = 0
	wave_number = 1
