extends Node

signal no_energy
signal energy_changed
signal max_energy_changed

var energy
var max_energy
var player_stats : Dictionary = {
	"max_life" : 100,
	"life" : 100
}

func change_energy(amount : int):
	clamp(energy + amount, 0, max_energy)
	if energy <= 0:
		no_energy.emit()
	energy_changed.emit()

func change_max_energy(amount : int):
	max_energy += amount
	max_energy_changed.emit()
