extends Node2D

var grid: Array = []
const GAP: int = 2


func _ready() -> void:
	setup_grid()


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
