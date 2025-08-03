extends CharacterBody2D

var Bullet = preload("res://Scene/playerbullet.tscn")

var speed = 200
var health = 3
var canshoot = true

@onready var gunpos1 = $GunPos1
@onready var gunpos2 = $GunPos2
@onready var muzzleflash1 = $MuzzleFlash1
@onready var muzzleflash2 = $MuzzleFlash2
@onready var flash_sprite1 = $Flash1
@onready var flash_sprite2 = $Flash2

func _ready() -> void:
	flash_sprite1.visible = false
	flash_sprite2.visible = false

func _physics_process(_delta) -> void:
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		movement.y -= 1
	if Input.is_action_pressed("Down"):
		movement.y += 1
	if Input.is_action_pressed("Left"):
		movement.x -= 1
	if Input.is_action_pressed("Right"):
		movement.x += 1
	
	velocity = movement.normalized() * speed
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 30, 1250)
	global_position.y = clamp(global_position.y, 40, 690)


func _on_shoot_speed_timeout() -> void:
	canshoot = true
	
func _process(_delta) -> void:
	if Input.is_action_pressed("Shoot") and canshoot:
		shoot()

func shoot():
	# Gun Position 1
	var bullet_1 = Bullet.instantiate()
	bullet_1.position = gunpos1.global_position
	get_parent().add_child(bullet_1)
	
	# Gun Position 2
	var bullet_2 = Bullet.instantiate()
	bullet_2.position = gunpos2.global_position
	get_parent().add_child(bullet_2)
	
	muzzleflash1.play("MuzzleFlash1")
	muzzleflash2.play("MuzzleFlash2")
	
	$ShootSpeed.start()
	canshoot = false
	
func player_hit():
	health -= 1
	Global.health -= 1
	if health == 0:
		call_deferred("_on_player_death")

func _on_player_death():
	get_tree().change_scene_to_file("res://Scene/gameover.tscn")
	queue_free()
