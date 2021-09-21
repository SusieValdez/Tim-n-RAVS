extends Control

func _ready():
	$AnimationPlayer.play("TitleDance")

func _on_PlayButton_pressed():
	Globals.start_game()

func _on_Button_mouse_entered():
	Globals.random_child($Sounds).play()
