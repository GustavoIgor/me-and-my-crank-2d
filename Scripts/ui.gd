extends CanvasLayer
@onready var energy_label := $UpperPanel/HBoxContainer/Energy/ProgressBar/Numbers
@onready var energy_progress_bar := $UpperPanel/HBoxContainer/Energy/ProgressBar
@onready var minerals_numbers := $UpperPanel/HBoxContainer/Minerals/Numbers
@onready var crystals_numbers := $UpperPanel/HBoxContainer/Crystals/Numbers
@onready var infuseds_numbers := $UpperPanel/HBoxContainer/Infuseds/Numbers

func _ready() -> void:
	Global.energy_changed.connect(_on_energy_changed)
	Global.max_energy_changed.connect(_on_energy_changed)
	Global.stat_changed.connect(_on_stats_changed)
	_on_energy_changed()
	_on_max_energy_changed()
	_on_stats_changed()
	
func _on_energy_changed():
	energy_label.text = str(Global.energy) + "/" + str(Global.max_energy)
	energy_progress_bar.value = Global.energy

func _on_max_energy_changed():
	energy_label.text = str(Global.energy) + "/" + str(Global.max_energy)
	energy_progress_bar.max_value = Global.max_energy

func _on_stats_changed():
	minerals_numbers.text = str(Global.stats['minerals'])
	crystals_numbers.text = str(Global.stats['crystals'])
	infuseds_numbers.text = str(Global.stats['infuseds'])
