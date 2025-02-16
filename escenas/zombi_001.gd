extends PathFollow2D

var velocidad = 0.05
var vida = 10
var attacking = false  # Track if it's currently attacking
var target_in_area = false  # Track if the plant is still inside

func _ready():
	$AnimatedSprite2D.play("caminar")

func _process(delta):
	if not attacking and $AnimatedSprite2D.animation == "caminar":
		progress_ratio += velocidad * delta

	if vida <= 0:
		$AnimatedSprite2D.play("dead")
		await $AnimatedSprite2D.animation_finished
		queue_free()

	if progress_ratio >= 1:
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("planta"):
		target_in_area = true
		if not attacking:
			start_attacking()

	if area.is_in_group("bala"):
		vida -= 1
		print(vida)

func _on_area_2d_area_exited(area):
	if area.is_in_group("planta"):
		target_in_area = false
		if not attacking:  # Only switch to "caminar" if not attacking
			$AnimatedSprite2D.play("caminar")
			print("caminar")

func start_attacking():
	attacking = true
	while target_in_area:  # Keep attacking while the plant is present
		$AnimatedSprite2D.play("comer")
		$attack/attack_collision.set_deferred("disabled", false)

		await $AnimatedSprite2D.animation_finished

		$attack/attack_collision.set_deferred("disabled", true)
		

		# If the plant is gone, stop attacking and resume movement
		if not target_in_area:
			attacking = false
			$AnimatedSprite2D.play("caminar")
			break
