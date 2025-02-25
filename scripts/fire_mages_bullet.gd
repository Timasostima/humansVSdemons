extends Node2D

const speed = 100
const damage = 15
var end_anim = false

func _process(delta):
	if !end_anim:
		position.x += speed * delta * 1.5
	else:
		position.x += speed/10 * delta * 1.5
		position.y -= speed/5 * delta * 1.5

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		end_anim = true
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite2D.play("hit_animation")
		area.get_parent().hp -= damage
		await $AnimatedSprite2D.animation_finished
		queue_free()
