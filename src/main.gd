extends Node2D

@onready var leaderboard_scene = preload("res://Main/Leaderboard_Modified.tscn")

#func _ready():
#	Utils.loadGame()

func _on_quit_button_pressed():
	get_tree().quit();


func _on_play_button_pressed():
	Utils.gameReset()
	get_tree().change_scene_to_file("res://Main/World.tscn");

func _on_leader_board_pressed():
#	get_tree().change_scene_to_file("res://leaderboard.tscn")
	get_tree().change_scene_to_packed(leaderboard_scene)
