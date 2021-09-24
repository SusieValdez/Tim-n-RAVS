extends Control

func _ready():
	$AnimationPlayer.play("TitleDance")

func _input(event):
	if event.is_action_pressed("menu") && Globals._is_playing:
		Globals.load_level()

func _on_PlayButton_pressed():
	Globals.start_game()

func _on_Button_mouse_entered():
	Globals.random_child($Sounds).play()

func _on_QuitButton_pressed():
	get_tree().quit()
