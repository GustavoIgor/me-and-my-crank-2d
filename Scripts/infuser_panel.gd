extends Panel

@onready var progress_bar := $VBoxContainer/ProgressBar
@onready var result_label := $VBoxContainer/ResultLabel
@onready var button := $VBoxContainer/Button

var cooldown_duration := 2.0
var cooldown_time_left := 0.0
var on_cooldown := false

func _process(delta):
	if on_cooldown:
		cooldown_time_left -= delta
		var percent = clamp(1.0 - (cooldown_time_left / cooldown_duration), 0.0, 1.0)
		progress_bar.value = percent * 100

		if cooldown_time_left <= 0.0:
			on_cooldown = false
			button.disabled = false
			progress_bar.value = 0
			result_label.text = ""  # limpa resultado

func _on_infuse_pressed() -> void:
	if on_cooldown:
		return

	var cost_minerals := 2
	var cost_crystals := 1

	if Global.stats['minerals'] < cost_minerals or Global.stats['crystals'] < cost_crystals:
		result_label.text = "Not enough resources!"
		return

	# Deduz recursos
	Global.change_stats('minerals', -cost_minerals)
	Global.change_stats('crystals', -cost_crystals)

	# Adiciona recurso fundido
	Global.change_stats('infuseds', 1)

	# Feedback
	result_label.text = "+1 Infused Material"

	# Inicia cooldown
	on_cooldown = true
	cooldown_time_left = cooldown_duration
	progress_bar.value = 0
	button.disabled = true
