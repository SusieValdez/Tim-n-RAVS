extends Node

var network = NetworkedMultiplayerENet.new()
var port = 29292
var max_players = 100
var server_ip

func start_server():
	network.connect("peer_connected", self, "_on_peer_connected")
	network.connect("peer_disconnected", self, "_on_peer_disconnected")
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started on port " + str(port))

func _on_peer_connected(player_id):
	print("Player " + str(player_id) + " has connected")

func _on_peer_disconnected(player_id):
	print("Player " + str(player_id) + " has disconnected")

func start_client(ip):
	network.connect("connection_succeeded", self, "_on_connection_succeeded")
	network.connect("connection_failed", self, "_on_connection_failed")
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	server_ip = ip
	print("Client started")

func _on_connection_succeeded():
	print("Connected to server at " + server_ip + ":" + str(port))

func _on_connection_failed():
	print("Connecting to server failed")

func get_ip_address():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip
	return "127.0.0.1"
