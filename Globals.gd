extends Node

var player: Player
var _level = 0
var _num_capsules_per_level = [
	0, # 1
	0, # 2
	0, # 3
	0, # 4
	0, # 5
	0, # 6
	0, # 7
	0, # 8
	0, # 9
	0, # 10
	0, # 11
	0, # 12
]

func next_level():
	_level += 1

func add_capsule(level=_level):
	_num_capsules_per_level[level] += 1

func get_num_capsules(level=_level):
	return _num_capsules_per_level[level]
