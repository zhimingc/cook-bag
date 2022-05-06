extends Node2D

export var hexgrid_obj : PackedScene
export var grid_dims	: Vector2
export var grid_scale	: float
export var grid_offset	: Vector2

class Array2D:
	var array = []
	var dims : Vector2
	
	func _init():
		pass
	
	func init_grid(grid_dims):
		array.clear()
		dims = grid_dims
		for y in dims[1]:
			for x in dims[0]:
#				if (x % 2 == 0 and y == 0) or (x % 2 == 1 and y == dims[1] - 1):
#					array.append(0)
#				else:
				array.append(1)
	
	func get_elem(x, y):
		var index = x + (y * dims[0])
		if index < array.size():
			return array[index]
		return -1
		
	func set_elem(x, y, elem):
		var index = x + (y * dims[0])
		if index < array.size():
			array[index] = elem

var grid : Array2D
var gridObjs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# init grid
	get_grid().init_grid(grid_dims)
	# draw grid here
	draw_grid()
	
# @@ need to offset hex tiles for grid here
func draw_grid():
	var origin = Vector2(-grid.dims[0], grid.dims[1]) * grid_scale * grid_offset / Vector2(2, 2)
	var quart_y_step = (grid_offset[1] / 4) * grid_scale
	for y in grid.dims[1]:
		for x in grid.dims[0]:
			if grid.get_elem(x, y) == 0:
				continue
			var newGrid = hexgrid_obj.instance() as Node2D
			newGrid.position = origin + Vector2(x * grid_offset[0], y * -grid_offset[1]) * grid_scale
			if x % 2 == 0:
				newGrid.position.y += quart_y_step
			else:
				newGrid.position.y -= quart_y_step
			newGrid.scale = Vector2.ONE * grid_scale
			add_child(newGrid)
			gridObjs.append(newGrid)

func set_dims(new_dims):
	grid_dims = new_dims
	get_grid().init_grid(grid_dims)
	draw_grid()
	
func get_grid():
	if grid == null:
		grid = Array2D.new()
	return grid
