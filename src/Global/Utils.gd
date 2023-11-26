extends Node

var player_name = "plaiddroid"

func _ready():
	var config = JSON.parse_string(FileAccess.open_encrypted_with_pass("res://env/config.json", FileAccess.READ, "L@72%MdNc!K6UldqoyNMUiGyhDEoVB$kXlO5bXJydRGkWZJzuczMwe2@cRAz@KoTvla9WDeO&BVeZ#RxfiG7*Fy@UZ$xm3KUunZ*wtGWxVP*%7hWxFybggaWMoKGt7^M").get_line())
	SilentWolf.configure(config)
#
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://main.tscn"
	})

func saveGame():
	var sw_savescore_result: Dictionary = await SilentWolf.Scores.save_score(player_name, Game.gold).sw_save_score_complete
	print("Score persisted successfully: " + str(sw_savescore_result.score_id))

func gameReset():
	Game.playerHP = 10
	Game.gold = 0
