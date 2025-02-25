extends Node2D

const speed = 100
const damage = 20

func _process(delta):
	position.x += speed * delta * 1.5

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().hp -= damage
		print(area.get_parent().hp)
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("fly_animation")
