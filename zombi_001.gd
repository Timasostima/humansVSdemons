extends Node2D

var velocidad = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("caminar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x -= velocidad * _delta
	
