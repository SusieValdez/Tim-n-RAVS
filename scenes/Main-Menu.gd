extends Control

func _ready():
	$AnimationPlayer.play("TitleDance")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/Level1.tscn")
