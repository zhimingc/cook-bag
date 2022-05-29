extends Node

enum INGAME_STATE {
	idle,
	travel,
	encounter,
	pause
}

export var encounter_interval = Vector2()

var state = INGAME_STATE.idle
var encounter_timer = 0.0

func init():
	encounter_timer = rand_range(encounter_interval.x, encounter_interval.y)

func set_state(new_state):
	# on exit state
	state = new_state
	# on enter state
	match state:
		INGAME_STATE.travel:
			set_next_encounter()
			pass
		INGAME_STATE.encounter:
			pass

func update_state(delta):
	match state:
		INGAME_STATE.idle:
			pass
		INGAME_STATE.travel:
			encounter_timer -= delta
			if encounter_timer <= 0.0:
				set_state(INGAME_STATE.encounter)
			pass
		INGAME_STATE.encounter:
			pass

func _process(delta):
	update_state(delta)

func set_next_encounter(_time = 0.0):
	encounter_timer = rand_range(encounter_interval.x, encounter_interval.y)	
