extends Node2D

class_name AlgorithmManager

enum Algorithms { BFS, DFS, DFID, ASTAR, DFBNB }
const algorithms_paths: Dictionary = {
	Algorithms.BFS: "res://Scenes/BfsAlgorithm/BfsAlgorithm.tscn",
	Algorithms.DFS: "",
	Algorithms.DFID: "res://Scenes/DfidAlgorithm/DfidAlgorithm.tscn",
	Algorithms.ASTAR: "res://Scenes/AstarAlgorithm/AstarAlgorithm.tscn",
	Algorithms.DFBNB: ""
}
const algorithms_names: Dictionary = {
	Algorithms.BFS: "BFS",
	Algorithms.DFS: "DFS",
	Algorithms.DFID: "DFID",
	Algorithms.ASTAR: "A*",
	Algorithms.DFBNB: "DFBNB"
}

var current_algorithm: String = algorithms_paths[Algorithms.BFS]
var is_algorithm_running: bool = false
var grid: Grid


func _ready() -> void:
	grid = find_parent("Grid")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("turn_on_algorithm"):
		grid.soft_clear_grid()
		if grid.is_start_cell_initialized() and grid.is_end_cell_initialized():
			var start_cell = grid.get_cell_at_index(grid.start_cell_index)
			var end_cell = grid.get_cell_at_index(grid.end_cell_index)
			var algorithm = load(current_algorithm).instantiate()
			add_child(algorithm)
			await algorithm.find_path(grid)

	if Input.is_action_just_pressed("change_to_bfs"):
		set_algorithm(Algorithms.BFS)
	# elif Input.is_action_just_pressed("change_to_dfs"):
	# 	set_algorithm(Algorithms.DFS)
	elif Input.is_action_just_pressed("change_to_dfid"):
		set_algorithm(Algorithms.DFID)
	elif Input.is_action_just_pressed("change_to_astar"):
		set_algorithm(Algorithms.ASTAR)
	# elif Input.is_action_just_pressed("change_to_dfbnb"):
	# 	set_algorithm(Algorithms.DFBNB)


func set_algorithm(algorithm_name: Algorithms) -> void:
	current_algorithm = algorithms_paths[algorithm_name]
	Globals.current_algorithm_name = algorithms_names[algorithm_name]
