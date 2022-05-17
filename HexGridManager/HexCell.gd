extends Node2D

class_name HexCell

enum INTERACT_STATE {
	idle,
	hover,
	select
}

enum CELL_STATE {
	empty,
	occupied
}

signal mouse_entered_hex
signal mouse_exit_hex

export (Color) var hover_tint
export (Color) var select_tint

var coordinates : Vector2
var area : Area2D
var cell_state = CELL_STATE.empty
var interact_state = INTERACT_STATE.idle

func _ready():
	area = $Area2D
	area.connect("mouse_entered", self, "on_mouse_entered")
	area.connect("mouse_exited", self, "on_mouse_exit")
	
func set_coords(coords : Vector2):
	coordinates = coords
	$Debug_Canvas/Debug_Coords.text = String(coords)
	
func set_cell_state(new_state):
	cell_state = new_state

func set_interact_state(new_state):
	interact_state = new_state
	match interact_state:
		INTERACT_STATE.idle:
			modulate = Color.white
		INTERACT_STATE.hover:
			modulate = hover_tint
		INTERACT_STATE.select:
			modulate = select_tint

func on_mouse_entered():
	emit_signal("mouse_entered_hex", self)
	
func on_mouse_exit():
	emit_signal("mouse_exit_hex", self)


