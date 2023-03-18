extends CharacterBody3D

#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var direction = 0



func _ready():

	if direction:
		$AnimatedSprite3d.play("walk")
		direction = -1
		velocity.x = -1


func _physics_process(_delta):
	if is_on_wall():
		direction *= -1
	$AnimatedSprite3d.flip_h = direction > 0
	velocity.x = 1 * direction

#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * _delta
		


	move_and_slide()



func _on_sides_checker_body_entered(_body):
	if _body.is_in_group("player"):
		_body.hurt()
	elif _body.get_collision_layer() == 1:
		_body.hurt()
	elif _body.get_collision_layer() == 32:
		_body.queue_free()
		queue_free()

