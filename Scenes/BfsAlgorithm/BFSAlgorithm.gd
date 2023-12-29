extends Node2D


# Breadth-First Search pathfinding algorithm
func find_path(grid: Grid) -> Array:
	var start = grid.index_to_coordinate(grid.start_cell_index)
	var parent: Dictionary = {start: null}
	var end = grid.index_to_coordinate(grid.end_cell_index)
	var visited: Dictionary = {start: null}
	grid.get_cell_at_coordinate(start).make_visited()
	var queue: Array = [start]

	while queue.size() > 0:
		var current_position: Vector2 = queue.pop_front()

		# Placeholder condition to check if we reached the end
		if current_position == end:
			return await reconstruct_path(start, end, parent, grid)

		# Placeholder logic to get neighbors (e.g., in a grid)
		var neighbors: Array = get_neighbors(current_position, grid)

		for neighbor in neighbors:
			if neighbor not in visited.keys():
				parent[neighbor] = current_position
				visited[neighbor] = null
				grid.get_cell_at_coordinate(neighbor).make_visited()
				await get_tree().create_timer(0.01).timeout

				queue.append(neighbor)

	# If we reach here, no path found
	return []


func reconstruct_path(start: Vector2, end: Vector2, parent: Dictionary, grid) -> Array:
	var path: Array = [end]
	var current_position: Vector2 = end

	while current_position != start:
		await get_tree().create_timer(0.01).timeout
		grid.get_cell_at_coordinate(current_position).make_path()
		current_position = parent[current_position]
		path.push_front(current_position)

	return path


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
