extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var player
var chase = false

func _ready():
	$AnimatedSprite2D.play("Idle")
	
func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Jump")
		player = $"../../Player/Player"
		var direction = (player.position - self.position).normalized()
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		velocity.x = direction.x * SPEED
	else:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_kills_body_entered(body):
	if body.name == "Player":
		death()
		body.jump()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3

func death():
	chase = false
	Game.gold += 1
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	self.queue_free()
