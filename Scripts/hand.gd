extends Panel

@onready var progress_bar := $VBoxContainer/ProgressBar
@onready var result_label := $VBoxContainer/ResultLabel
@onready var button := $VBoxContainer/Use

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
			result_label.text = ""  # limpa resultado após o cooldown

func _on_use_pressed() -> void:
	if on_cooldown:
		return
	use()

func use():
	if Global.energy <= 20:
		result_label.text = "No energy for this action."
		return
	
	Global.play_hand.emit()
	Global.change_energy(-20)

	# Gera materiais
	var minerals = randi_range(1, 3)
	var crystals = randi_range(0, 2)
	Global.change_stats('minerals', minerals)
	Global.change_stats('crystals', crystals)

	# Exibe resultado
	result_label.text = "+%d minerals\n+%d crystals" % [minerals, crystals]

	# Inicia cooldown
	on_cooldown = true
	cooldown_time_left = cooldown_duration
	progress_bar.value = 0
	button.disabled = true
