extends Node

enum INGAME_STATE {
	idle,
	travel,
	encounter,
	pause
}

var state = INGAME_STATE.idle
var next_encounter : EncMan.Encounter

func init():
	randomize()
	next_encounter = EncMan.get_new_encounter()

func set_state(new_state):
	# on exit state
	state = new_state
	# on enter state
	match state:
		INGAME_STATE.travel:
			set_next_encounter()
			pass
		INGAME_STATE.encounter:
			EncMan.add_child(next_encounter.encounter_obj)
			pass

func update_state(delta):
	match state:
		INGAME_STATE.idle:
			pass
		INGAME_STATE.travel:
			next_encounter.encounter_timer -= delta
			if next_encounter.encounter_timer <= 0.0:
				set_state(INGAME_STATE.encounter)
			pass
		INGAME_STATE.encounter:
			pass

func _process(delta):
	update_state(delta)

func set_next_encounter():
	next_encounter = EncMan.get_new_encounter()
