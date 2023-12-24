extends Sprite2D

var is_obstacle: bool = false
const OBSTACLE_COLOR: Color = Color(0, 0, 0)
const EMPTY_COLOR: Color = Color(1, 1, 1)
const GAP: int = 0


func _ready() -> void:
	var screen_size = get_viewport_rect().size - Vector2(GAP, GAP) * Globals.grid_size
	scale = Vector2(screen_size.x / Globals.grid_size.x, screen_size.y / Globals.grid_size.y)
	print(scale)


func make_obstacle() -> void:
	is_obstacle = true
	update_visual()


func make_empty() -> void:
	is_obstacle = false
	update_visual()


func update_visual() -> void:
	modulate = OBSTACLE_COLOR if is_obstacle else EMPTY_COLOR
