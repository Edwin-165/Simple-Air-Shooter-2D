extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")
	Global.health = 3
	Global.score = 0

func _on_quit_pressed() -> void:
	get_tree().quit()
