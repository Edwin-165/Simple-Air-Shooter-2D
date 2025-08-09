extends CharacterBody2D

var Bullet = preload("res://Scene/enemybullet.tscn")
var Explosion = preload("res://Scene/explosion.tscn")

var player = null

@export var speed = 2
@export var health = 3

@onready var gunpos = $GunPos
@onready var muzzleflash = $MuzzleFlash
@onready var flash_sprite = $Flash
@onready var shotSpeed = $ShotSpeed

func _ready() -> void:
	flash_sprite.visible = false

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
	
	muzzleflash.play("MuzzleFlash")
	shotSpeed.start()

func enemy_hit():
	health -= 1
	if health == 0:
		Global.camera.screen_shake(5.0, 5.0, 0.05)
		Global.score += 5
		var explosion = Explosion.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		queue_free()
