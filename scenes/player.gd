extends CharacterBody2D

const SPEED = 200.0

func _physics_process(delta):
	
	Move(delta)
		
	move_and_slide()
		
func Move(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement != 0:
		if movement > 0.0:
			velocity.x += SPEED * delta
			velocity.x = clamp(SPEED, 100, SPEED)
			$Sprite2D.flip_h = false
			$AnimationPlayer.play("Walk")
			
		if movement < 0.0:
			velocity.x -= SPEED * delta
			velocity.x = clamp(SPEED, -100, -SPEED)
			$Sprite2D.flip_h = true
			$AnimationPlayer.play("Walk")
	
	if movement == 0.0:
		velocity.x = 0.0
		$AnimationPlayer.play("Idle")
