extends Object

class_name Utils

class Array2D:	
	var array = []
	var dims : Vector2
	
	func _init():
		pass
	
	func init_array(array_dims, fill = true):
		array.clear()
		dims = array_dims
		for y in dims[1]:
			for x in dims[0]:
				array.append(1 if fill else 0)
	
	func get_elem(x, y):
		var index = x + (y * dims[0])
		if index < array.size():
			return array[index]
		return -1
		
	func set_elem(x, y, elem):
		var index = x + (y * dims[0])
		if index < array.size():
			array[index] = elem

class HexGrid_Doubled:
	var grid_array : Array2D
	var gridObjs = []
	var grid_pixel
	var grid_scale
	
	func _init():
		grid_array = Array2D.new()
		
	func init_shape(array, dims):
		grid_array.init_array(dims * Vector2(1, 2), false)
		# map 2d array preview to doubled coordinates
		for y in dims[1]:
			for x in dims[0]:
				var dy = y * 2 if x % 2 == 0 else y * 2 + 1
				var index = x+(dy*grid_array.dims[0])
				grid_array.array[index] = array[x+y*dims[0]]
		
	func init_grid(grid_dims, _grid_pixel = 32, _grid_scale = 1):
		grid_array.init_array(grid_dims * Vector2(1, 2))
		grid_pixel = _grid_pixel
		grid_scale = _grid_scale
		
	func draw_grid(parent, origin):
		var grid_obj = preload("res://HexGridManager/HexCell.tscn")
		var final_scale = grid_pixel * grid_scale
		var quart_y_step = final_scale.y / 4
		for y in grid_array.dims[1]:
			for x in grid_array.dims[0]:
				if (y + x) % 2 != 0:
					continue
				if grid_array.get_elem(x, y) == 0:
					continue
				var newGrid = grid_obj.instance() as Node2D
				newGrid.position = origin + Vector2(x * final_scale[0], y * final_scale[1] / 2.0)
				newGrid.scale = Vector2.ONE * grid_scale
				newGrid.set_coords(Vector2(x, y))
				parent.add_child(newGrid)
				gridObjs.append(newGrid)
	
	func get_hex(x, y):
		var index = x + (y * grid_array.dims[0])
		for grid in gridObjs:
			if grid.coordinates == Vector2(x,y):
				return grid
		return null

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
				newGrid.set_coords(Vector2(x, y))
				parent.add_child(newGrid)
				gridObjs.append(newGrid)

	func parse_hex_traverse(hex : HexCell, vec):
		# if hex.coordinates.x is even 
			# -x needs to +1y
		# if hex.coordinates.x is odd
			# +x needs to -1y
		pass

	func get_hex(x, y):
		var index = x + (y * grid_array.dims[0])
		if index < gridObjs.size():
			return gridObjs[index]
		return null
