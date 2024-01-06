extends CanvasLayer


func _ready():
	Globals.connect("algorithm_changed", update_algorithm_name_text)


func update_algorithm_name_text(algorithm_name):
	get_node("Label").text = "Algorithm: " + algorithm_name
