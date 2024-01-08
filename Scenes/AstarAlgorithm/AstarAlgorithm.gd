extends Node2D


# A* Search pathfinding algorithm
func find_path(grid: Grid) -> Array:
	var start = grid.index_to_coordinate(grid.start_cell_index)
	var end = grid.index_to_coordinate(grid.end_cell_index)

	var open_set: Array = [start]
	var closed_set: Array = []
	var parent: Dictionary = {}

	var g_score: Dictionary = {}
	var f_score: Dictionary = {}

	g_score[start] = 0
	f_score[start] = get_heuristic(start, end)

	while open_set.size() > 0:
		var current_position: Vector2 = get_lowest_f_score(open_set, f_score)
		if current_position == end:
			return await reconstruct_path(start, end, parent, grid)

		open_set.erase(current_position)
		closed_set.push_back(current_position)

		for neighbor in get_neighbors(current_position, grid):
			if closed_set.find(neighbor) != -1:
				continue

			var tentative_g_score: float = g_score[current_position] + 1
			if open_set.find(neighbor) == -1:
				await get_tree().create_timer(0.01).timeout
				grid.get_cell_at_coordinate(neighbor).make_visited()
				open_set.push_back(neighbor)
			elif tentative_g_score >= g_score[neighbor]:
				continue

			parent[neighbor] = current_position
			g_score[neighbor] = tentative_g_score
			f_score[neighbor] = g_score[neighbor] + get_heuristic(neighbor, end)

	return []


func get_heuristic(position: Vector2, end: Vector2) -> float:
	return abs(position.x - end.x) + abs(position.y - end.y)


func get_lowest_f_score(open_set: Array, f_score: Dictionary) -> Vector2:
	var lowest_f_score: float = 1000000
	var lowest_f_score_position: Vector2 = Vector2()

	for position in open_set:
		if f_score[position] < lowest_f_score:
			lowest_f_score = f_score[position]
			lowest_f_score_position = position

	return lowest_f_score_position


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
