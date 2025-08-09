extends ParallaxBackground

func _process(delta: float) -> void:
	scroll_base_offset -= Vector2(40, 0) * delta
