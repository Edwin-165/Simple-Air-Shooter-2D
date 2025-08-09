extends CharacterBody2D

var Bullet = preload("res://Scene/bossbullet.tscn")

var canshoot = false
var player = null

var speed = 1
var health = 50

var travel = false
var startpos = 0
var distance = 200

@onready var gunpos1 = $GunPos1
@onready var gunpos2 = $GunPos2

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _ready():
	startpos = position.y

func _physics_process(delta: float) -> void:
	var movement = Vector2(-speed, 0)
	
	if player:
		movement = Vector2(0, 0)
		travel_move()
		shoot()
	move_and_collide(movement)
	
func travel_move():
	if position.y > startpos + distance:
		travel = false
	if position.y < startpos - distance:
		travel = true
	if travel:
		up()
	else:
		down()

func up():
	position.y += 2
func down():
	position.y -= 2

func _on_shotspeed_timeout() -> void:
	canshoot = true

func shoot():
	if canshoot:
		# Gun Position 1
		var bullet1 = Bullet.instantiate()
		bullet1.position = gunpos1.global_position
		get_parent().add_child(bullet1)
		
		# Gun Position 2
		var bullet2 = Bullet.instantiate()
		bullet2.position = gunpos2.global_position
		get_parent().add_child(bullet2)
		
		$Shotspeed.start()
		canshoot = false

func enemy_hit():
	health -= 1
	if health == 0:
		Global.camera.screen_shake(10.0, 10.0, 0.05)
		Global.score += 100
		queue_free()
