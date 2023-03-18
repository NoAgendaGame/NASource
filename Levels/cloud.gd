extends CharacterBody3D

#Get the gravity from the project settings to be synced with RigidBody nodes.

@export var direction = 0



func _ready():

	if direction:
		direction = -1
		velocity.x = -1


func _physics_process(_delta):
	if is_on_wall():
		direction *= -1
	velocity.x = 1 * direction



	move_and_slide()

