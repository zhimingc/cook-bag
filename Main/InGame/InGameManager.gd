extends Node

enum INGAME_STATE {
	idle,
	travel,
	encounter,
	pause
}

var state = INGAME_STATE.idle
var current_encounter : EncMan.Encounter

func init():
	randomize()
	current_encounter = EncMan.get_new_encounter()

func set_state(new_state):
	# on exit state
	state = new_state
	# on enter state
	match state:
		INGAME_STATE.travel:
			# remove current encounter
			current_encounter.encounter_obj.clear_encounter()
			set_next_encounter()
			pass
		INGAME_STATE.encounter:
			EncMan.add_child(current_encounter.encounter_obj)
			pass

func update_state(delta):
	match state:
		INGAME_STATE.idle:
			pass
		INGAME_STATE.travel:
			current_encounter.encounter_timer -= delta
			if current_encounter.encounter_timer <= 0.0:
				set_state(INGAME_STATE.encounter)
			pass
		INGAME_STATE.encounter:
			pass

func _process(delta):
	update_state(delta)

func set_next_encounter():
	current_encounter = EncMan.get_new_encounter()
