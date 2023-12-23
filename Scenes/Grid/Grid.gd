extends Node2D

var grid: Array = []
var block_mode: bool = false
const GAP: int = 2


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


func create_grid_cell(x: int, y: int) -> Control:
	var cell = preload("res://Scenes/GridCell/GridCell.tscn").instantiate()
	cell.position = (Vector2(x * (Globals.cell_size.x + GAP), y * (Globals.cell_size.y + GAP)))
	add_child(cell)
	return cell


func get_cell_at_position(cellPosition: Vector2) -> Control:
	var x = int(cellPosition.x / (Globals.cell_size.x + GAP))
	var y = int(cellPosition.y / (Globals.cell_size.y + GAP))
	var cellIndex = y + x * int(Globals.grid_size.x)
	if cellIndex < 0 or cellIndex >= grid.size():
		return null
	return grid[cellIndex]
