extends Node2D

# Include scripts for different algorithms
const ALGORITHM_BFS: String = "res://Algorithms/BFSAlgorithm.gd"

var current_algorithm: String = ALGORITHM_BFS
var algorithm_instance: Node2D


func _ready() -> void:
	# Instantiate the selected algorithm
	algorithm_instance = load(current_algorithm).instantiate()
	add_child(algorithm_instance)


func set_algorithm(algorithm_name: String) -> void:
	# Remove the current algorithm instance
	if algorithm_instance != null:
		algorithm_instance.queue_free()

	# Instantiate and add the new algorithm
	current_algorithm = algorithm_name
	algorithm_instance = load(current_algorithm).instance()
	add_child(algorithm_instance)
