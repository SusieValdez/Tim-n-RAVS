extends Control

var server_ip = "127.0.0.1"

func _ready():
	$AnimationPlayer.play("TitleDance")
	$PlayButton.grab_focus()
	$IPAddress.text = Network.get_ip_address()

func _input(event):
	if event.is_action_pressed("menu") && Globals.is_playing():
		Globals.load_level()

func _on_PlayButton_pressed():
	Network.start_server()
	Globals.start_game()

func _on_ServerIP_text_changed(new_text):
	server_ip = new_text

func _on_JoinButton_pressed():
	Network.start_client(server_ip)
	Globals.start_game()

func _on_QuitButton_pressed():
	get_tree().quit()
