extends Area2D

func _ready():
	$AnimatedSprite2D.play("Idle")

func _on_body_entered(body):
	if body.name == "Player":
		Game.playerHP += 1
		queue_free()
