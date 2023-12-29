extends Node2D

enum Algorithms { BFS, DFS, DFID, ASTAR, DFBNB }
const algorithms_paths: Dictionary = {
	Algorithms.BFS: "res://Algorithms/BFSAlgorithm.gd",
	Algorithms.DFS: "res://Algorithms/DFSAlgorithm.gd",
	Algorithms.DFID: "res://Algorithms/DFIDAlgorithm.gd",
	Algorithms.ASTAR: "res://Algorithms/AStarAlgorithm.gd",
	Algorithms.DFBNB: "res://Algorithms/DFBNBAlgorithm.gd"
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
			var algorithm = preload("res://Scenes/BfsAlgorithm/BfsAlgorithm.tscn").instantiate()
			add_child(algorithm)
			await algorithm.find_path(grid)

# func set_algorithm(algorithm_name: String) -> void:
# 	# Remove the current algorithm instance
# 	if algorithm_instance != null:
# 		algorithm_instance.queue_free()

# 	# Instantiate and add the new algorithm
# 	current_algorithm = algorithm_name
# 	algorithm_instance = load(current_algorithm).instance()
# 	add_child(algorithm_instance)
