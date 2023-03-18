extends CharacterBody3D


const FIRE = preload("res://Player/Adam/itm_shot.tscn")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var money = 0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mirrored = false;


@onready var state_machine = $AnimationTree.get("parameters/playback")

var is_hurt := false

func fire():
	if Input.is_action_just_pressed("fire2"):
		$SubViewport/Node2D/Head/Mouth.play("openMouth")
		
		state_machine.travel("fire")
		var direction = 1 if not $Sprite3D.flip_h else -1
		var v = FIRE.instantiate()
		v.direction = direction
		get_parent().add_child(v)
		v.position.y = position.y + 0
		v.position.x = position.x + 1 * direction
		v.position.z = position.z + 1 * direction
		await get_tree().create_timer(1.5).timeout
		
		


func hurt():
	if is_hurt:
		return
	is_hurt = true
	$AudioStreamPlayer.play()
	state_machine.travel("hurt")
	$SubViewport/Node2D/Head/Mouth.play("hurt")
	await get_tree().create_timer(0.5).timeout
	is_hurt = false


func _physics_process(_delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * _delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept2") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left2", "ui_right2", "ui_up2", "ui_down2")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if not is_on_floor():
		state_machine.travel("jump")
	elif velocity != Vector3.ZERO:
		state_machine.travel("walk")
	elif not is_hurt:
		state_machine.travel("idle")
		$SubViewport/Node2D/Head/Mouth.play("default")
	

	# This flips the player sprite to face the direction the player wants to go in.
	if direction.x > 0: mirrored = false
	elif direction.x < 0: mirrored = true
	$Sprite3D.flip_h = mirrored
	move_and_slide()
	fire()



