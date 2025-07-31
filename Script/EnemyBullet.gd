extends Area2D

var speed = 400

func _physics_process(delta: float) -> void:
	position.x -= delta * speed

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player_hit"):
		body.player_hit()
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
