extends Node2D

var can_attack = false
var bullet = preload("res://escenas/bullet.tscn")
var hp = 100

func _ready():
	$hitbox_area/hitbox.disabled = true
	$AnimatedSprite2D.play("idle")
	$short_attack_area/short_attack.disabled = true


func _process(_delta):
	if hp <= 0:
		$hitbox_area/hitbox.disabled = true
		$AnimatedSprite2D.play("dead")
		await $AnimatedSprite2D.animation_finished
		$".".queue_free()
	elif can_attack:
		$hitbox_area/hitbox.disabled = false
	detect_demon()

func detect_demon():
	#if $short_attack.is_colliding() and can_attack:
		#$AnimatedSprite2D.play("short_attack")
	if $long_attack.is_colliding() and can_attack:
		$AnimatedSprite2D.play("long_attack")
	else:
		$AnimatedSprite2D.play("idle")

func attack():
	var new_bullet = bullet.instantiate()
	$Marker2D.add_child(new_bullet)


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "long_attack" and $AnimatedSprite2D.frame == 12:
		attack()
