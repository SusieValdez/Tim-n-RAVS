extends Node

var player: Player
var _level = 0
var _num_capsules_per_level = {}

func start_game():
	_level = 0
	_num_capsules_per_level = {}
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
		get_tree().change_scene("res://scenes/Main-Menu.tscn")
