extends Node2D

class_name Item

enum INTERACT_STATE {
	idle,
	hover,
	drag,
	stored
}

var hexgrid
# var shape : Utils.HexGrid
var shape : Utils.HexGrid_Doubled
var state = INTERACT_STATE.idle
var mouse_offset
var snap_offset
var selected_hex = []
var last_position = Vector2()
var stored = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hexgrid = get_tree().get_root().get_node("Main/HexGridMan")
	shape = Utils.HexGrid_Doubled.new()
	shape.grid_pixel = Vector2(95, 110)
	shape.grid_scale = 0.5
	
func _process(delta):
	match state:
		INTERACT_STATE.hover:
			if Input.is_action_just_pressed("lmb") and ItemMan.is_currently_holding() == false:
				set_state(INTERACT_STATE.drag)
				ItemMan.set_held_item(self)
				if stored:
					hexgrid.item_removed_from_bag()
					stored = false
			pass			
		INTERACT_STATE.drag:
			position = get_global_mouse_position() + mouse_offset
			pass

func set_state(new_state):
	# exit state
	# match state:

	state = new_state
	
	# enter state
	match state:
		INTERACT_STATE.idle:
			if selected_hex.size() > 0:
				set_state(INTERACT_STATE.hover)
		INTERACT_STATE.drag:
			mouse_offset = position - get_global_mouse_position()
			last_position = position
	
func gen_grid():
	shape.draw_grid(self, null)
	for obj in shape.gridObjs:
		obj.connect("mouse_entered_hex", self, "mouse_enter")
		obj.connect("mouse_exit_hex", self, "mouse_exit")
		obj.modulate = Color.gray
	
func mouse_enter(hex : HexCell):
	selected_hex.append(hex)	
	if state == INTERACT_STATE.idle:
		set_state(INTERACT_STATE.hover)
	
func mouse_exit(hex : HexCell):
	selected_hex.erase(hex)
	if selected_hex.size() == 0 and state == INTERACT_STATE.hover:
		set_state(INTERACT_STATE.idle)

func get_selected_hex():
	if selected_hex.size() > 0:
		return selected_hex[0]
	return null

func release_item():
	set_state(INTERACT_STATE.idle)

func snap_position(snap_pos):
	set_state(INTERACT_STATE.idle)
	position = position + (snap_pos - selected_hex[0].global_position)
	
func return_to_last_position():
	position = last_position
