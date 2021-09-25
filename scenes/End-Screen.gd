extends Control

func _ready():
	var level_stats = Globals.get_level_stats()
	var play_time = Globals.get_play_time()
	$CurrentRun/Panel/Stats.text = "Levels:\n%s\nTotal Time:\n%s\n\nDeaths:\n%s" % [level_stats, play_time, Globals.num_deaths]
	$GoBackButton.grab_focus()

func _on_GoBackButton_pressed():
	return get_tree().change_scene("res://scenes/Main-Menu.tscn")
