extends CanvasLayer
@onready var test = $Test

func _ready() -> void:
	Global.energy_changed.connect(_on_energy_changed)
	
func _on_energy_changed():
	test.text = str(Global.energy)
