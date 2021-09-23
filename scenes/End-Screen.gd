extends Control

func _on_GoBackButton_pressed():
	get_tree().change_scene("res://scenes/Main-Menu.tscn")


func _on_GoBackButton_mouse_entered():
	Globals.random_child($Sounds).play()
