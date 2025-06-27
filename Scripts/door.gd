extends StaticBody2D
@export var required_minerals: int = 5
@export var required_crystals: int = 2
@export var required_infuseds: int = 0

@onready var sprite := $Sprite2D
@onready var collider := $CollisionShape2D
@onready var player := %Player

var is_open := false
var player_inside := false

func open_ui():
	Utilities.set_door(self)
	Utilities.show_door_panel()

func try_open():
	if Global.stats['minerals'] >= required_minerals and Global.stats['crystals'] >= required_crystals and Global.stats['infuseds'] >= required_infuseds:
		Global.change_stats('minerals', -required_minerals)
		Global.change_stats('crystals', -required_crystals)
		Global.change_stats('infuseds', -required_infuseds)
		open_door()
		return true
	else:
		return false

func open_door():
	Global.game_unpaused.emit()
	is_open = true
	collider.disabled = true
	sprite.modulate = Color(1, 1, 1, 0.5)  # visual de "aberta"


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player_inside = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_open:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if player_inside:
			open_ui()
