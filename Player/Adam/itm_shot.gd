extends CharacterBody3D

#var velocity = Vector3()
var direction = 1
const SPEED = 10

func _ready():
	velocity.x = SPEED * direction
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished

func _physics_process(_delta):
	
	if is_on_wall():
		await $AudioStreamPlayer.finished
		queue_free()
	
	move_and_slide()


func _on_visible_on_screen_notifier_3d_screen_exited():
	await $AudioStreamPlayer.finished
	queue_free()



	
