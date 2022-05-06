extends Object

class_name Utils

class Array2D:	
	var array = []
	var dims : Vector2
	
	func _init():
		pass
	
	func init_array(array_dims):
		array.clear()
		dims = array_dims
		for y in dims[1]:
			for x in dims[0]:
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

class HexGrid:
	var grid_array : Array2D
	var gridObjs = []
	var grid_pixel
	var grid_scale
	
	func _init():
		grid_array = Array2D.new()
		
	func init_grid(grid_dims, _grid_pixel = 32, _grid_scale = 1):
		grid_array.init_array(grid_dims)
		grid_pixel = _grid_pixel
		grid_scale = _grid_scale
		
	func draw_grid(parent, origin):
		var grid_obj = preload("res://HexGridManager/HexCell.tscn")
		var final_scale = grid_pixel * grid_scale
		var quart_y_step = final_scale.y / 4
		for y in grid_array.dims[1]:
			for x in grid_array.dims[0]:
				if grid_array.get_elem(x, y) == 0:
					continue
				var newGrid = grid_obj.instance() as Node2D
				newGrid.position = origin + Vector2(x * final_scale[0], y * final_scale[1])
				if x % 2 == 0:
					newGrid.position.y += quart_y_step
				else:
					newGrid.position.y -= quart_y_step
				newGrid.scale = Vector2.ONE * grid_scale
				parent.add_child(newGrid)
				gridObjs.append(newGrid)
