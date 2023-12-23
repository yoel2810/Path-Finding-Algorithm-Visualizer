extends Control

var is_obstacle: bool = false
var is_hovered: bool = false
const OBSTACLE_COLOR: Color = Color(0, 0, 0)
const EMPTY_COLOR: Color = Color(1, 1, 1)


func _ready() -> void:
	size = Globals.cell_size
	var sprite: Sprite2D = get_node("Sprite2D")
	var scale_vector = Vector2(
		Globals.cell_size.x / sprite.texture.get_width(),
		Globals.cell_size.y / sprite.texture.get_height()
	)
	sprite.scale = scale_vector
	sprite.position -= scale_vector * size


func _process(_delta) -> void:
	if Input.is_action_just_pressed("place_obstacle") and is_hovered:
		toggle_obstacle()


func _on_mouse_entered() -> void:
	is_hovered = true


func _on_mouse_exited():
	is_hovered = false


func toggle_obstacle() -> void:
	is_obstacle = !is_obstacle
	update_visual()


func update_visual() -> void:
	var cell_sprite: Sprite2D = get_node("Sprite2D")
	cell_sprite.modulate = OBSTACLE_COLOR if is_obstacle else EMPTY_COLOR
