extends Panel

@onready var progress_bar := $VBoxContainer/ProgressBar
@onready var result_label := $VBoxContainer/ResultLabel
@onready var button := $VBoxContainer/Use
@onready var auto_button := $VBoxContainer/Auto
@onready var label := $VBoxContainer/Label

var cooldown_duration := 2.0
var cooldown_time_left := 0.0
var on_cooldown := false

var automation_unlocked := false
var automation_enabled := false
var automation_timer := 0.0

func _ready():
	update_automation_button()

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
	
	if automation_enabled:
		automation_timer -= delta
		if automation_timer <= 0.0:
			run_automated_grab()
			automation_timer = cooldown_duration

func _on_use_pressed() -> void:
	if on_cooldown:
		return
	use()

func use():
	if Global.energy < 20:
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

func run_automated_grab():
	var auto_cost := 5
	if Global.energy < auto_cost:
		return
	
	Global.change_energy(-auto_cost)
	
	var minerals = randi_range(2, 6)
	var crystals = randi_range(0, 4)
	
	Global.change_stats('minerals', minerals)
	Global.change_stats('crystals', crystals)
	
	result_label.text = "[Auto] +%d minerals\n+%d crystals" % [minerals, crystals]

func _on_auto_pressed() -> void:
	if !automation_unlocked:
		if Global.stats['infuseds'] >= 10:
			Global.change_stats('infuseds', -10)
			automation_unlocked = true
			automation_enabled = true
			button.visible = false
			progress_bar.visible = false
			label.text = ""
			update_automation_button()
		else:
			result_label.text = "You need 10 infuseds."
	else:
		automation_enabled = !automation_enabled
		update_automation_button()

func update_automation_button():
	if !automation_unlocked:
		auto_button.text = "Automate"
	elif automation_enabled:
		auto_button.text = "TURN OFF"
	else:
		auto_button.text = "TURN ON"
