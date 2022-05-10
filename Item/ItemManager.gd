extends Node

var held_item : Item
var last_held : Item
var just_released

func _ready():
	process_priority = -10

func set_held_item(new_item):
	last_held = held_item
	held_item = new_item
	
func get_held_item():
	return held_item

func get_last_held():
	return last_held

func release_current_held():
	held_item.release_item()
	set_held_item(null)
	just_released = true

func is_currently_holding():
	return held_item != null

func _process(delta):
	just_released = false
	if is_currently_holding() and Input.is_action_just_released("lmb"):
		release_current_held()
