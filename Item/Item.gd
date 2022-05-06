extends Node2D

enum INTERACT_STATE {
	idle,
	hover,
	drag
}

var hexgrid : HexGridManager

var shape : Utils.HexGrid
var state = INTERACT_STATE.idle
var mouse_offset
var selected_hex = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hexgrid = get_tree().get_root().get_node("HexGridMan")
	shape = Utils.HexGrid.new()
	shape.grid_pixel = Vector2(95, 110)
	shape.grid_scale = 0.5
	
func _process(delta):
	match state:
		INTERACT_STATE.hover:
			if Input.is_action_just_pressed("lmb"):
				set_state(INTERACT_STATE.drag)
			pass
		INTERACT_STATE.drag:
			position = get_global_mouse_position() + mouse_offset
			if Input.is_action_just_released("lmb"):
				set_state(INTERACT_STATE.idle)
			pass

func set_state(new_state):
	state = new_state
	match state:
		INTERACT_STATE.idle:
			if selected_hex.size() > 0:
				set_state(INTERACT_STATE.hover)
		INTERACT_STATE.drag:
			mouse_offset = position - get_global_mouse_position()
	
func gen_grid():
	shape.draw_grid(self, Vector2(0,0))
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
