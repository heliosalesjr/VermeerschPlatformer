extends StaticBody2D

var health = 3

func _on_hitbox_area_entered(area):
	if area.name == "Sword":
		$anim.play("hurt")
		health -= 1
		await $anim.animation_finished
		$anim.play("active")
		if health <= 0:
			$anim.play("destroyed")
			queue_free()
