extends Node

enum ENCOUNTER_TYPE {
	forage,
	person,
}

class Encounter:
	var type = ENCOUNTER_TYPE.forage
	var encounter_timer = 0.0	
	var encounter_obj
	
var encounter_interval = Vector2(2.0, 5.0)
# hard coded encounter sequence
var encounter_sequence = [ ENCOUNTER_TYPE.forage ]
var encounter_counter = 0

var encounter_map = {}

func _ready():
	encounter_map[ENCOUNTER_TYPE.forage] = load(get_encounter_path("ForageEncounter"))

func get_encounter_path(_name):
	return "res://Encounters/" + _name + "/" + _name + ".tscn"

func get_new_encounter():
	var new_encounter : Encounter = Encounter.new()
	new_encounter.encounter_obj = get_hardcoded_encounter()
	new_encounter.encounter_timer = rand_range(encounter_interval.x, encounter_interval.y)
	return new_encounter

func get_hardcoded_encounter():
	var next_encounter = encounter_sequence[encounter_counter]
	var new_encounter = encounter_map[next_encounter].instance()
	encounter_counter = (encounter_counter + 1) % encounter_sequence.size()
	return new_encounter
