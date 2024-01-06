extends Node2D


# dfid Search pathfinding algorithm
func find_path(grid: Grid):
	for depth in range(0, 1000):
		var H: Array = []
		var start = grid.index_to_coordinate(grid.start_cell_index)
		var parent: Dictionary = {start: null}
		var end = grid.index_to_coordinate(grid.end_cell_index)
		var result = await limitedDFS(grid, start, end, depth, H, start, parent)
		if result != "cutoff":
			return result
		if result == "fail":
			return []
	return []


func limitedDFS(
	grid: Grid,
	current_position: Vector2,
	end: Vector2,
	depth: int,
	H: Array,
	start: Vector2,
	parent: Dictionary
):
	const CUTOFF = "cutoff"
	const FAIL = "fail"
	if current_position == end:
		await reconstruct_path(start, end, parent, grid)
		return ""
	if depth == 0:
		return CUTOFF
	H.append(current_position)
	grid.get_cell_at_coordinate(current_position).make_visited()
	await get_tree().create_timer(0.01).timeout
	var is_cutoff: bool = false
	for neighbor in get_neighbors(current_position, grid):
		if H.has(neighbor) == true:
			continue
		parent[neighbor] = current_position

		var result = await limitedDFS(grid, neighbor, end, depth - 1, H, start, parent)
		if result == CUTOFF:
			is_cutoff = true
		elif result != FAIL:
			return result

	H.erase(current_position)
	if current_position != start:
		grid.get_cell_at_coordinate(current_position).make_empty()
	if is_cutoff == true:
		return CUTOFF
	else:
		return FAIL


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
