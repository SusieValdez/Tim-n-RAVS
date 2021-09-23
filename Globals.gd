extends Node

var player: Player
var _level = 0
var _num_capsules_per_level = {}
var _music: AudioStreamPlayer = AudioStreamPlayer.new()
var _first_run = true

func _ready():
	add_child(_music)
	_music.stream = preload("res://assets/sounds/music.mp3")

func start_game():
	_level = 0
	_num_capsules_per_level = {}
	if _first_run:
		_music.play()
		_first_run = false
	load_level()

func next_level():
	_level += 1
	load_level()

func reset_level(level=_level):
	_num_capsules_per_level[level] = 0
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func add_capsule(level=_level):
	_num_capsules_per_level[level] += 1

func get_num_capsules(level=_level):
	var num_capsules = _num_capsules_per_level.get(level)
	if num_capsules == null:
		_num_capsules_per_level[level] = 0
		return 0
	return num_capsules

func load_level(level=_level):
	# warning-ignore:return_value_discarded
	if get_tree().change_scene("res://scenes/Level" + str(level + 1) + ".tscn") != OK:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/End-Scene.tscn")

func random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)
