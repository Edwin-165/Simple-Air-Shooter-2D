extends Node2D

var Enemy = preload("res://Scene/Enemy.tscn")



func _on_spawntimer_timeout() -> void:
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(randf_range(1280, 1280), randf_range(100, 550))
	add_child(enemy)
