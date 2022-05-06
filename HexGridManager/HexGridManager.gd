extends Node2D

class_name HexGridManager

export var hexgrid_obj : PackedScene
export var grid_dims	: Vector2
export var grid_pixel_size : Vector2
export var grid_scale	: float
export var grid_offset	: Vector2

var grid : Utils.HexGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	# init grid
	grid = Utils.HexGrid.new()
	grid.init_grid(grid_dims, grid_pixel_size, grid_scale)
	# draw grid here
	var final_scale = grid_pixel_size * grid_scale
	var origin_offset = Vector2(2.0, 1.0)
	var origin = Vector2(-grid_dims[0], -grid_dims[1]) / origin_offset * final_scale
	grid.draw_grid(self, origin)
	for obj in grid.gridObjs:
		obj.connect("mouse_entered_hex", self, "on_mouse_entered")
		
func on_mouse_entered(hex):
	pass
