extends Area3D

signal money_collected

func _on_money_body_entered(_body):
	$AnimationPlayer.play("bounce")
	$AudioStreamPlayer.play()
	emit_signal("money_collected")
	set_collision_mask_value(1,false)





func _on_animation_player_animation_finished(_anim_name):
	queue_free()



