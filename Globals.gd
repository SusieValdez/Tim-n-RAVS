extends Node

const NUM_LEVELS = 10

var player: Player
var _music: AudioStreamPlayer = AudioStreamPlayer.new()
var _is_playing = false
var level_id_regex = RegEx.new()

var num_deaths = 0
var _level = 0
var _level_capsules = []
var _level_times = []

func _reset():
	_is_playing = true
	num_deaths = 0
	_level = get_current_level()
	_level_capsules = []
	_level_times = [OS.get_ticks_msec()]
	for x in NUM_LEVELS:
		_level_capsules.append(0)
		_level_times.append(0)

func _ready():
	level_id_regex.compile("(\\d+)")
	add_child(_music)
	_music.stream = preload("res://assets/sounds/music.mp3")
	_music.play()

func start_game():
	_reset()
	load_level()

func get_current_level():
	var scene_filename = get_tree().current_scene.filename
	print(scene_filename)
	var id_match = level_id_regex.search(scene_filename)
	if id_match:
		return int(id_match.get_string()) - 1
	else:
		return 0

func next_level(level=_level+1):
	_level = level
	_level_times[level] = OS.get_ticks_msec()
	load_level(level)

func load_level(level=_level):
	if level == NUM_LEVELS:
		_is_playing = false
		return get_tree().change_scene("res://scenes/End-Screen.tscn")
	_level_capsules[level] = 0
	return get_tree().change_scene("res://scenes/levels/Level" + str(level + 1) + ".tscn")

func add_capsule(level=_level):
	_level_capsules[level] += 1

func get_num_capsules(level=_level):
	return _level_capsules[level]

func is_playing():
	return _is_playing

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
