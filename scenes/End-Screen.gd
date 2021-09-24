extends Control

func _ready():
	Globals._is_playing = false
	var level_stats = Globals.get_level_stats()
	var elapsed = Globals.get_play_time()
	$CurrentRun/Panel/Stats.text = "Levels:\n%s\n\nTotal Time:\n%s\n\nDeaths:\n%s" % [level_stats, elapsed, Globals.num_deaths]

func _on_GoBackButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Main-Menu.tscn")

func _on_GoBackButton_mouse_entered():
	Globals.random_child($Sounds).play()
