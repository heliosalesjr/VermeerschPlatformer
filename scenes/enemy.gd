extends CharacterBody2D
@onready var anim = $anim
@onready var ray_cast_y = $RayCastY
@onready var ray_cast_x = $RayCastX

var moving_left = true
var speed = 15
var gravity = 30

func _physics_process(delta):
	Move()
	floor_detect()

func Move():
	$anim.play("idle")
	if moving_left:
		velocity.x = speed
	else:
		velocity.x = -speed
	
	move_and_slide()
	
func floor_detect():
	if !$RayCastY.is_colliding() && is_on_floor():
		moving_left = !moving_left
		scale.x = -scale.x
	elif !$RayCastX.is_colliding() && is_on_wall():
		moving_left = !moving_left
		scale.x = -scale.x
