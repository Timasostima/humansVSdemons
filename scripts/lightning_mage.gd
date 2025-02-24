extends Node2D

var can_attack = false
var bullet = preload("res://scenes/lightning_mages_bullet.tscn")
var hp = 80
const short_atk_dmg = 25

func _ready():
	$hitboxArea/hitbox.set_deferred("disabled", true)
	$AnimatedSprite2D.play("idle")
	$shortAttackArea/attackArea.set_deferred("disabled", true)

func _process(_delta):
	check_hp()
	if hp <= 0:
		$hitboxArea/hitbox.set_deferred("disabled", true)
		$AnimatedSprite2D.play("dead")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	elif can_attack:
		$hitboxArea/hitbox.set_deferred("disabled", false)
	detect_demon()

func check_hp():
	hp = 0 if hp < 0 else hp
	$hpLabel.text = str(hp)
	if hp > 60:
		$hpLabel.add_theme_color_override("font_color", Color("00ff00"))
	elif hp > 40:
		$hpLabel.add_theme_color_override("font_color", Color("66ff00"))
	elif hp > 20:
		$hpLabel.add_theme_color_override("font_color", Color("ff6600"))
	elif hp > 0:
		$hpLabel.add_theme_color_override("font_color", Color("ff0000"))
	else:
		$hpLabel.add_theme_color_override("font_color", Color("000000"))

func detect_demon():
	if $short_attack.is_colliding() and can_attack:
			$AnimatedSprite2D.play("short_attack")
	elif $long_attack.is_colliding() and can_attack:
		$AnimatedSprite2D.play("long_attack")
	else:
		$AnimatedSprite2D.play("idle")

func fire_bullet():
	var new_bullet = bullet.instantiate()
	$Marker2D.add_child(new_bullet)

func short_attack():
	$shortAttackArea/attackArea.set_deferred("disabled", false)
	# Ensure the hitbox is disabled after a brief moment
	await get_tree().create_timer(0.2).timeout
	$shortAttackArea/attackArea.set_deferred("disabled", true)

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "short_attack" and $AnimatedSprite2D.frame == 2:
		short_attack()
	if $AnimatedSprite2D.animation == "long_attack" and $AnimatedSprite2D.frame == 2:
		fire_bullet()

func _on_short_attack_area_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().hp -= short_atk_dmg
		print("Enemy HP:", area.get_parent().hp)
