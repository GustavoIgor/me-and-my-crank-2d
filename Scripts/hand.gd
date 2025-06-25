extends Panel


func _on_use_pressed() -> void:
	use()
	
func use():
	if Global.energy <= 20:
		return
	Global.change_energy(-20)
	Global.change_stats('minerals', randi_range(0, 2))
	Global.change_stats('crystals', randi_range(0, 1))
