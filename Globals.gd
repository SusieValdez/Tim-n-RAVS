extends Node

var player: Player
var num_deaths = 0

var _is_playing = false
var _level = 0
var _music: AudioStreamPlayer = AudioStreamPlayer.new()
var _first_run = true
var _level_times = []
var _level_capsules = []

func _ready():
	add_child(_music)
	_music.stream = preload("res://assets/sounds/music.mp3")

func start_game():
	num_deaths = 0
	_is_playing = true
	_level = 0
	if _first_run:
		_music.play()
		_first_run = false
	_level_times = [OS.get_ticks_msec()]
	_level_capsules = [0]
	load_level()

func next_level():
	_level += 1
	var time_now = OS.get_ticks_msec()
	_level_times.append(time_now)
	_level_capsules.append(0)
	load_level()

func load_level(level=_level):
	_level_capsules[level] = 0
	# warning-ignore:return_value_discarded
	if get_tree().change_scene("res://scenes/Level" + str(level + 1) + ".tscn") != OK:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/End-Screen.tscn")

func add_capsule(level=_level):
	_level_capsules[level] += 1

func get_num_capsules(level=_level):
	return _level_capsules[level]

func random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)
	
func millis_to_str(elapsed):
	var secs = elapsed / 1000
	var minutes = secs / 60
	var hours = minutes / 60
	var seconds = secs % 60
	var millis = elapsed % 1000
	return "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, millis]


func get_splits():
	var splits = []
	for i in range(_level_times.size() - 1):
		var split_diff = _level_times[i + 1] - _level_times[i]
		splits.append(split_diff)
	return splits

func get_level_stats():
	var output = "";
	var splits = get_splits()
	for i in splits.size():
		var split_str = millis_to_str(splits[i])
		var capsules_str = "%d/4" % _level_capsules[i]
		output += "%s - %s\n" % [split_str, capsules_str]
	return output

func get_play_time():
	return millis_to_str(
		_level_times[len(_level_times) - 1] - _level_times[0]
	)
