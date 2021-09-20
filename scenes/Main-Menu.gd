extends Control

func _ready():
	$AnimationPlayer.play("TitleDance")

func _on_PlayButton_pressed():
	Globals.start_game()
