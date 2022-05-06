extends "res://Item/Item.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	shape.grid_array.array = [1, 1, 1,
							  1, 1, 1,
							  0, 1, 0]
	shape.grid_array.dims = Vector2(3, 3)
	gen_grid()
