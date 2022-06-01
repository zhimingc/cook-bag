extends Node

export var encounter_interval : Vector2

func _ready():
	EncMan.encounter_interval = encounter_interval
	Ingame.init()
