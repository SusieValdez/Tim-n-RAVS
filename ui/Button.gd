extends Button

func _on_Button_focus_entered():
	Globals.random_child($Sounds).play()

func _on_Button_mouse_entered():
	Globals.random_child($Sounds).play()
