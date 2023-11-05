extends CharacterBody2D

enum PlayerStates { MOVE, SWORD}
var CurrentState = PlayerStates.MOVE

const SPEED = 200.0
var gravity = 20
var jump = 400
var pressed = 2

func _ready():
	$Sword/CollisionShape2D.disabled = true

func _physics_process(delta):
#	Move(delta)
	
	match CurrentState:
		PlayerStates.MOVE:
			Move(delta)
		PlayerStates.SWORD:
			Sword()
	
	velocity.y += gravity
	move_and_slide()

		
func Move(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0:
		if movement > 0.0:
			velocity.x += SPEED * delta
			velocity.x = clamp(SPEED, 100, SPEED)
			$Sprite2D.flip_h = false
			$AnimationPlayer.play("Walk")
			$Sword/CollisionShape2D.position = Vector2(0,0)
			
		if movement < 0.0:
			velocity.x -= SPEED * delta
			velocity.x = clamp(SPEED, -100, -SPEED)
			$Sprite2D.flip_h = true
			$AnimationPlayer.play("Walk")
			$Sword/CollisionShape2D.position = Vector2(-50,0)
	
	if movement == 0.0:
		velocity.x = 0.0
		$AnimationPlayer.play("Idle")
		
	if Input.is_action_just_pressed("ui_jump"):
		pressed -= 1
		
	if is_on_floor() && Input.is_action_just_pressed("ui_jump"):
		Jump()
	
	if !is_on_floor() && Input.is_action_just_pressed("ui_jump") && pressed >= 1:
		Jump()
	
	if pressed <= 1:
		velocity.y = velocity.y
	
	if is_on_floor():
		pressed = 2
		
	if !is_on_floor():
		$AnimationPlayer.play("Jump")
		
	if !is_on_floor() && velocity.y > 10:
		$AnimationPlayer.play("Fall")

	if Input.is_action_just_pressed("ui_sword"):
		CurrentState = PlayerStates.SWORD
		velocity.x = movement
func Jump():
#	if Input.is_action_just_pressed("ui_jump"):
		velocity.y -= jump
		#$AnimationPlayer.play("Jump")
func Sword():
	$AnimationPlayer.play("Sword")

func OnStateFinished():
	CurrentState = PlayerStates.MOVE
