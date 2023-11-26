extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var RUSH

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if velocity.y > 0:
		$AnimationPlayer.play("Fall")
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		jump()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

	if Input.is_action_just_pressed("ui_rush"):
		RUSH = 10
	else:
		RUSH = 1
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$AnimationPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$AnimationPlayer.play("Idle")
	
	if Game.playerHP<=0:
		die()

	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	$AnimationPlayer.play("Jump")

func die():
	$AnimationPlayer.play("Death")
	queue_free()
	Utils.saveGame()
	get_tree().change_scene_to_file("res://main.tscn")
