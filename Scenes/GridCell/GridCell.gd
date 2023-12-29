extends Sprite2D

class_name GridCell

enum CellType { EMPTY, OBSTACLE, START, END, VISITED, PATH }
var cell_type = CellType.EMPTY
const COLORS: Dictionary = {
	CellType.EMPTY: Color(1, 1, 1),
	CellType.OBSTACLE: Color(0, 0, 0),
	CellType.START: Color(0, 1, 0),
	CellType.END: Color(1, 0, 0),
	CellType.PATH: Color(0, 0, 1),
	CellType.VISITED: Color(1, 0.56, 0.9),
}


func _ready() -> void:
	var screen_size = (
		get_viewport_rect().size - Vector2(Globals.GAP, Globals.GAP) * Globals.grid_size
	)
	scale = Vector2(screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y)


func make_path() -> void:
	if cell_type == CellType.START or cell_type == CellType.END:
		return
	cell_type = CellType.PATH
	update_visual()


func make_obstacle() -> void:
	if cell_type == CellType.START or cell_type == CellType.END:
		return
	cell_type = CellType.OBSTACLE
	update_visual()


func make_empty() -> void:
	cell_type = CellType.EMPTY
	update_visual()


func make_start() -> void:
	cell_type = CellType.START
	update_visual()


func make_end() -> void:
	if cell_type == CellType.START:
		return
	cell_type = CellType.END
	update_visual()


func make_visited() -> void:
	if cell_type == CellType.START or cell_type == CellType.END:
		return
	cell_type = CellType.VISITED
	update_visual()


func update_visual() -> void:
	modulate = COLORS[cell_type]


func is_obstacle() -> bool:
	return cell_type == CellType.OBSTACLE


func is_visited() -> bool:
	return cell_type == CellType.VISITED


func is_path() -> bool:
	return cell_type == CellType.PATH
