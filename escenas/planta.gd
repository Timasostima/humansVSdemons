extends Node2D


var bala = preload("res://escenas/bullet.tscn")
var vida = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if vida <= 0:
		$AnimatedSprite2D.play("dead")
		await $AnimatedSprite2D.animation_finished
		$".".queue_free()
	det_zombie()

func _on_area_2d_area_entered(area):
	print(area)
	if area.is_in_group("enemy_attack"):
		print("vida")
		vida -= 1
		


func _on_timer_timeout():
	vida -= 1

func det_zombie():
	if $RayCast2D.is_colliding():
		$AnimatedSprite2D.play("atacar")
	else:
		$AnimatedSprite2D.play("idle")
func ataque():
	var ataque = bala.instantiate()
	$Marker2D.add_child(ataque)


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "atacar":
		ataque()
