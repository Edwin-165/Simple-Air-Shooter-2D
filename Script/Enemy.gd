extends CharacterBody2D

var Bullet = preload("res://Scene/enemybullet.tscn")

var player = null

@export var speed = 2

@onready var gunpos = $GunPos
@onready var shotSpeed = $ShotSpeed

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		if shotSpeed.is_stopped():
			shotSpeed.start()

func _physics_process(_delta) -> void:
	var movement = Vector2(-2, 0)
	
	if player:
		movement = position.direction_to(player.position) * speed
	
	move_and_collide(movement)

func _on_shoot_speed_timeout() -> void:
	if player != null:
		shoot()

func shoot():
	var bullet = Bullet.instantiate()
	bullet.position = gunpos.global_position
	get_parent().add_child(bullet)
	
	shotSpeed.start()
