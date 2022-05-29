extends Node

export var encounter_interval : Vector2

func _ready():
	Ingame.encounter_interval = encounter_interval
	Ingame.init()
