extends Node2D

var can_attack = false
var bala = preload("res://escenas/bullet.tscn")
var vida = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	$hitbox_area/hitbox.disabled = true
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if vida <= 0:
		$hitbox_area/hitbox.disabled = true
		$AnimatedSprite2D.play("dead")
		await $AnimatedSprite2D.animation_finished
		$".".queue_free()
	elif can_attack:
		$hitbox_area/hitbox.disabled = false
	detect_zombie()

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy_attack"):
		vida -= 1

func detect_zombie():
	if $RayCast2D.is_colliding() and can_attack:
		$AnimatedSprite2D.play("attack")
	else:
		$AnimatedSprite2D.play("idle")

func attack():
	var ataque = bala.instantiate()
	$Marker2D.add_child(ataque)


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "attack" and $AnimatedSprite2D.frame == 6:
		attack()
