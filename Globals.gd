extends Node2D

signal algorithm_changed(algorithm_name: String)

var grid_size: Vector2 = Vector2(32, 18)
var current_algorithm_name: String = "BFS":
	set(value):
		current_algorithm_name = value
		algorithm_changed.emit(value)
const GAP: int = 2
