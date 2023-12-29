extends Node2D


# Breadth-First Search pathfinding algorithm
func find_path(grid: Grid) -> Array:
	var start = grid.index_to_coordinate(grid.start_cell_index)
	var end = grid.index_to_coordinate(grid.end_cell_index)
	var visited: Dictionary = {start: null}
	grid.get_cell_at_coordinate(start).make_visited()
	var queue: Array = [start]

	while queue.size() > 0:
		var current_position: Vector2 = queue.pop_front()

		# Placeholder condition to check if we reached the end
		if current_position == end:
			return reconstruct_path(start, end)

		# Placeholder logic to get neighbors (e.g., in a grid)
		var neighbors: Array = get_neighbors(current_position, grid)

		for neighbor in neighbors:
			if neighbor not in visited.keys():
				visited[neighbor] = null
				grid.get_cell_at_coordinate(neighbor).make_visited()
				await get_tree().create_timer(0.01).timeout

				queue.append(neighbor)

	# If we reach here, no path found
	return []


func reconstruct_path(start: Vector2, end: Vector2) -> Array:
	# Placeholder function to reconstruct the path
	# In a real implementation, you'd have the actual path reconstruction logic here
	return [start, Vector2(start.x + 1, start.y), end]


func get_neighbors(position: Vector2, grid: Grid) -> Array:
	var neighbors: Array = [
		position + Vector2(1, 0),
		position + Vector2(-1, 0),
		position + Vector2(0, 1),
		position + Vector2(0, -1)
	]
	return neighbors.filter(func(pos: Vector2): return is_valid_neighbor(pos, grid))


func is_valid_neighbor(position: Vector2, grid: Grid) -> bool:
	# Placeholder function to check if a position is a valid neighbor
	# In a real implementation, you'd have the actual logic based on your grid
	return (
		position.x >= 0
		and position.x < Globals.grid_size.x
		and position.y >= 0
		and position.y < Globals.grid_size.y
		and grid.get_cell_at_coordinate(position).is_obstacle() == false
	)
