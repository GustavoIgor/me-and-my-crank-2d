extends CanvasLayer
@onready var background_color := $ColorRect

func change_color(r : float, g : float, b : float, a : float):
	background_color.color = Color(r, g, b, a)
