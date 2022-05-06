extends Node2D

class_name HexCell

signal mouse_entered_hex
signal mouse_exit_hex

var coordinates : Vector2
var area : Area2D

func _ready():
	area = $Area2D
	area.connect("mouse_entered", self, "on_mouse_entered")
	area.connect("mouse_exited", self, "on_mouse_exit")
	
func on_mouse_entered():
	emit_signal("mouse_entered_hex", self)
	
func on_mouse_exit():
	emit_signal("mouse_exit_hex", self)
