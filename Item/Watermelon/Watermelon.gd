extends "res://Item/Item.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	var array = [0, 1, 0,
				 1, 1, 1,
				 1, 1, 1]
	var dims = Vector2(3, 3)
	shape.init_shape(array, dims)
	gen_grid()
