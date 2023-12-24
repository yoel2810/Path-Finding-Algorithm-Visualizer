extends Node2D

var grid: Array = []
var block_mode: bool = false
const GAP: int = 0


func _ready() -> void:
	setup_grid()


func _process(_delta):
	if Input.is_action_pressed("place_obstacle"):
		block_mode = true
	elif Input.is_action_just_released("place_obstacle"):
		block_mode = false

	var mouse_position = get_global_mouse_position()
	var current_cell = get_cell_at_position(mouse_position)
	if current_cell != null and block_mode:
		current_cell.make_obstacle()


func setup_grid() -> void:
	for x in range(int(Globals.grid_size.x)):
		for y in range(int(Globals.grid_size.y)):
			var cell = create_grid_cell(x, y)
			grid.append(cell)


func create_grid_cell(x: int, y: int) -> Sprite2D:
	var screen_size = get_viewport_rect().size - Vector2(GAP, GAP) * Globals.grid_size
	var cell_size = Vector2(
		screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y
	)
	var cell = preload("res://Scenes/GridCell/GridCell.tscn").instantiate()
	cell.position = Vector2(x * (cell_size.x + GAP), y * (cell_size.y + GAP)) + cell_size / 2
	add_child(cell)
	return cell


func get_cell_at_position(cellPosition: Vector2) -> Sprite2D:
	var screen_size = get_viewport_rect().size - Vector2(GAP, GAP) * Globals.grid_size
	var cell_size = Vector2(
		screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y
	)
	var x = int(cellPosition.x / (cell_size.x + GAP))
	var y = int(cellPosition.y / (cell_size.y + GAP))
	var cellIndex = y + x * int(Globals.grid_size.y)
	if cellIndex < 0 or cellIndex >= grid.size():
		return null
	return grid[cellIndex]
