extends Node

#General
signal no_energy
signal energy_changed
signal max_energy_changed
signal stat_changed
signal game_paused
signal game_unpaused

#Specific
signal play_hand

var energy := 50
var max_energy : = 100

var stats : Dictionary = {
	"minerals" : 0,
	"crystals" : 0,
	"infuseds" : 0
}

var player_stats : Dictionary = {
	"max_life" : 100,
	"life" : 100
}

func change_energy(amount : int):
	energy = clamp(energy + amount, 0, max_energy)
	if energy <= 0:
		no_energy.emit()
	energy_changed.emit()

func change_max_energy(amount : int):
	max_energy += amount
	max_energy_changed.emit()

func change_stats(stat : String, amount : int):
	stats[stat] += amount
	stat_changed.emit()
