extends Control

func _ready():
	$AnimationPlayer.play("TitleDance")
	$PlayButton.grab_focus()

func _input(event):
	if event.is_action_pressed("menu") && Globals.is_playing():
		Globals.load_level()

func _on_PlayButton_pressed():
	Globals.start_game()

func _on_QuitButton_pressed():
	get_tree().quit()
