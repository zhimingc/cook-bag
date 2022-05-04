tool
extends Node2D

export var hexgrid_obj : PackedScene
export var grid_dims	: Vector2 setget set_dims
export var grid_offset	: Vector2

class Array2D:
	var array = []
	var dims : Vector2
	
	func init(grid_dims):
		array.clear()
		dims = grid_dims
		for y in dims[1]:
			for x in dims[0]:
				if (y % 2 == 0 and x == 0) or (y % 2 == 1 and x == dims[0] - 1):
					array.append(0)
				else:
					array.append(1)
	
	func get_elem(x, y):
		var index = x + (y * dims[0])
		if index < array.len:
			return array[index]
		return -1
		
	func set_elem(x, y, elem):
		var index = x + (y * dims[0])
		if index < array.len:
			array[index] = elem

var grid : Array2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# init grid
	grid.init(grid_dims)
	# @ draw grid here
	
func set_dims(new_dims):
	grid.init(grid_dims)	
	
