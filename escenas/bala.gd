extends Node2D

var velocidad = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x += velocidad * _delta * 1.5

func _on_area_2d_area_entered(area):
	if area.is_in_group("zombie"):
		$".".queue_free()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("fly_animation")
	pass # Replace with function body.
