extends Node2D

var grid_size: Vector2 = Vector2(10, 10)
var cell_size: Vector2 = Vector2(32, 32)
var grid: Array = []


func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for x in range(int(grid_size.x)):
		for y in range(int(grid_size.y)):
			var cell = create_grid_cell(x, y)
			grid.append(cell)


func create_grid_cell(x: int, y: int) -> Control:
	var cell: Control = Control.new()
	cell.size = cell_size
	cell.position = Vector2(x * cell_size.x, y * cell_size.y)

	# Customize the appearance of the cell (e.g., add a Sprite)
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	cell.add_child(sprite)
	sprite.scale = Vector2(
		cell_size.x / sprite.texture.get_width(), cell_size.y / sprite.texture.get_height()
	)

	# Add the cell as a child of the main node
	add_child(cell)

	return cell
