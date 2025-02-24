extends PathFollow2D

const MOVING_SPEED = 0.05
const DAMAGE = 15

var hp = 100
var attacking = false  
var target_in_area = false
var loot = true

func _ready():
	$coin.visible = true
	$coin.modulate.a = 0.0
	$coin.get_node("coinLabel").text = "+5"
	$AnimatedSprite2D.play("walk")

func _process(delta):
	check_hp()
	if not attacking and $AnimatedSprite2D.animation == "walk":
		progress_ratio += MOVING_SPEED * delta

	if hp <= 0:
		die()
	
	if progress_ratio >= 0.99:
		Global.hearts_remaining -= 1
		print("Remaining hearts: ", Global.hearts_remaining)
		queue_free()

func check_hp():
	hp = 0 if hp < 0 else hp
	$hpLabel.text = str(hp)
	if hp > 75:
		$hpLabel.add_theme_color_override("font_color", Color("00ff00"))
	elif hp > 50:
		$hpLabel.add_theme_color_override("font_color", Color("66ff00"))
	elif hp > 25:
		$hpLabel.add_theme_color_override("font_color", Color("ff6600"))
	elif hp > 0:
		$hpLabel.add_theme_color_override("font_color", Color("ff0000"))
	else:
		$hpLabel.add_theme_color_override("font_color", Color("000000"))


func _on_area_2d_area_entered(area):
	if area.is_in_group("ally"):
		target_in_area = true
		if not attacking:
			start_attacking(area)

func _on_area_2d_area_exited(area):
	if area.is_in_group("ally"):
		target_in_area = false
		if attacking:
			stop_attacking()

func start_attacking(target):
	attacking = true
	while target_in_area and hp > 0:
		$AnimatedSprite2D.play("attack")
		$attack/attack_collision.set_deferred("disabled", false)

		await $AnimatedSprite2D.animation_finished

		$attack/attack_collision.set_deferred("disabled", true)
		
		if is_instance_valid(target) and hp > 0:
			var defender = target.get_parent()
			defender.hp -= DAMAGE
			
			print("defender hp:", defender.hp)
			if defender.hp <= 0:
				stop_attacking()

		if not target_in_area:
			stop_attacking()
			break

func stop_attacking():
	attacking = false
	$AnimatedSprite2D.play("walk")

func die():
	$hitbox/hitbox_collision.set_deferred("disabled", true)
	$attack/attack_collision.set_deferred("disabled", true)
	$AnimatedSprite2D.play("die")
	target_in_area = false

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($coin, "modulate:a", 1.0, 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)  # Smoother fade-in
	tween.tween_property($coin, "scale", Vector2(1, 1), 1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)  # Small pop effect
	tween.tween_property($coin, "position", $coin.position + Vector2(0, -7), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)  # More noticeable upward movement
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0, 0.8).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property($hpLabel, "modulate:a", 0, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	
	await $AnimatedSprite2D.animation_finished
	await tween.finished	
	
	$coin.visible = false
	
	queue_free()
	if loot:
		Global.kill(1, 5)
		loot = false
	


