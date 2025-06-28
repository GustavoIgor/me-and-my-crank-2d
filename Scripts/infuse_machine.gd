extends StaticBody2D
@onready var player = %Player

var player_inside := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player_inside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player_inside = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if player_inside:
			Utilities.show_hand()
