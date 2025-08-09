extends Node2D

var Enemy = preload("res://Scene/Enemy.tscn")
var Boss = preload("res://Scene/boss.tscn")

func _on_spawntimer_timeout() -> void:
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(randf_range(1280, 1280), randf_range(100, 550))
	add_child(enemy)

func _on_bosstimer_timeout() -> void:
	$Spawntimer.stop()
	var boss = Boss.instantiate()
	boss.position = Vector2(randf_range(1280, 1280), randf_range(320, 320))
	add_child(boss)
	$Bosstimer.stop()
