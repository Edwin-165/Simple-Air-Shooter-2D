extends Area2D

var speed = 400

func _physics_process(delta: float) -> void:
	position.x += delta * speed
