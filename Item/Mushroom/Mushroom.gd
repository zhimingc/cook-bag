extends "res://Item/Item.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	shape.grid_array.array = [1]
	shape.grid_array.dims = Vector2(1, 1)
	gen_grid()
