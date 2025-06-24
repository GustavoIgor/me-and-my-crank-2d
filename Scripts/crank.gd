extends Panel

@onready var crank_texture := $CrankTexture

var dragging := false
var last_angle := 0.0
var energy_buffer := 0.0  # acumula até 1 int para enviar via `change_energy`

func _input(event):
	if !visible:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			if dragging:
				last_angle = get_mouse_angle()

	if dragging and event is InputEventMouseMotion:
		var current_angle = get_mouse_angle()
		var delta = wrapf(current_angle - last_angle, -PI, PI)
		last_angle = current_angle

		crank_texture.rotation += delta

		# Acumula energia de forma fracionada
		var delta_degrees = abs(rad_to_deg(delta))
		energy_buffer += delta_degrees * 0.01  # ajuste esse valor para calibrar geração

		# Quando acumular 1 ponto inteiro, aplica com change_energy()
		if energy_buffer >= 1.0:
			var int_amount = int(energy_buffer)
			energy_buffer -= int_amount
			Global.change_energy(int_amount)

func get_mouse_angle() -> float:
	var mouse_pos = get_global_mouse_position()
	var center = crank_texture.get_global_rect().get_center()
	return (mouse_pos - center).angle()
