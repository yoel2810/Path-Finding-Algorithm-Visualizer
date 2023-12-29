extends Node2D

class_name Grid

signal frame_updated

var grid: Array = []
var start_cell_index: int = -1
var end_cell_index: int = -1
var block_mode: bool = false


func _ready() -> void:
	setup_grid()


func _process(_delta):
	if Input.is_action_pressed("place_obstacle"):
		block_mode = true
	elif Input.is_action_just_released("place_obstacle"):
		block_mode = false

	var mouse_position = get_global_mouse_position()
	var current_cell = get_cell_at_mouse_position(mouse_position)
	if current_cell != null and block_mode:
		current_cell.make_obstacle()

	if Input.is_action_just_pressed("put_special_node"):
		if !is_start_cell_initialized():
			start_cell_index = coordinate_to_index(
				mouse_coordinates_to_grid_coordinates(mouse_position).x,
				mouse_coordinates_to_grid_coordinates(mouse_position).y
			)
			grid[start_cell_index].make_start()
		elif !is_end_cell_initialized():
			end_cell_index = coordinate_to_index(
				mouse_coordinates_to_grid_coordinates(mouse_position).x,
				mouse_coordinates_to_grid_coordinates(mouse_position).y
			)
			grid[end_cell_index].make_end()


func soft_clear_grid() -> void:
	for cell in grid:
		if cell.is_visited() or cell.is_path():
			cell.make_empty()


func is_start_cell_initialized() -> bool:
	return start_cell_index != -1


func is_end_cell_initialized() -> bool:
	return end_cell_index != -1


func setup_grid() -> void:
	for x in range(int(Globals.grid_size.x)):
		for y in range(int(Globals.grid_size.y)):
			var cell = create_grid_cell(x, y)
			grid.append(cell)


func create_grid_cell(x: int, y: int) -> Sprite2D:
	var screen_size = (
		get_viewport_rect().size - Vector2(Globals.GAP, Globals.GAP) * Globals.grid_size
	)
	var cell_size = Vector2(
		screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y
	)
	var cell = preload("res://Scenes/GridCell/GridCell.tscn").instantiate()
	cell.position = (
		Vector2(x * (cell_size.x + Globals.GAP), y * (cell_size.y + Globals.GAP)) + cell_size / 2
	)
	add_child(cell)
	return cell


func get_cell_at_mouse_position(cellPosition: Vector2) -> Sprite2D:
	var grid_coordinates = mouse_coordinates_to_grid_coordinates(cellPosition)
	var cellIndex = coordinate_to_index(grid_coordinates.x, grid_coordinates.y)
	if cellIndex < 0 or cellIndex >= grid.size():
		return null
	return grid[cellIndex]


func get_cell_at_index(index: int) -> GridCell:
	return grid[index]


func get_cell_at_coordinate(coordinates: Vector2) -> GridCell:
	return grid[coordinate_to_index(coordinates.x, coordinates.y)]


func mouse_coordinates_to_grid_coordinates(mouse_position: Vector2) -> Vector2:
	var screen_size = (
		get_viewport_rect().size - Vector2(Globals.GAP, Globals.GAP) * Globals.grid_size
	)
	var cell_size = Vector2(
		screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y
	)
	var x = int(mouse_position.x / (cell_size.x + Globals.GAP))
	var y = int(mouse_position.y / (cell_size.y + Globals.GAP))
	return Vector2(x, y)


func coordinate_to_index(x: int, y: int) -> int:
	return y + x * int(Globals.grid_size.y)


func index_to_coordinate(index: int) -> Vector2:
	var x = index / int(Globals.grid_size.y)
	var y = index % int(Globals.grid_size.y)
	return Vector2(x, y)
