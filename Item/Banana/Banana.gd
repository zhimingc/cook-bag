extends "res://Item/Item.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	shape.grid_array.array = [1, 1,
							  1, 0,
							  0, 1]
	shape.grid_array.dims = Vector2(2, 3)
	gen_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
