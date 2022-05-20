extends Node2D

class_name HexGridManager

export var hexgrid_obj : PackedScene
export var grid_dims	: Vector2
export var grid_pixel_size : Vector2
export var grid_scale	: float
export var grid_offset	: Vector2

var grid : Utils.HexGrid
var grid_doubled : Utils.HexGrid_Doubled
var hovered_hex = []
var itemover_hex = []

func grid():
	return grid_doubled

func init_all_grids():
	grid = Utils.HexGrid.new()
	grid.init_grid(grid_dims, grid_pixel_size, grid_scale)
	grid_doubled = Utils.HexGrid_Doubled.new()
	grid_doubled.init_grid(grid_dims, grid_pixel_size, grid_scale)	

# Called when the node enters the scene tree for the first time.
func _ready():
	# init grid
	init_all_grids()
	# draw grid here
	var final_scale = grid_pixel_size * grid_scale
	var origin_offset = Vector2(2.0, 1.0)
	var origin = Vector2(-grid_dims[0], -grid_dims[1]) / origin_offset * final_scale
	grid().draw_grid(self, origin)
	for obj in grid().gridObjs:
		obj.connect("mouse_entered_hex", self, "on_mouse_entered")
		obj.connect("mouse_exit_hex", self, "on_mouse_exit")
		
func _process(delta):
	if hovered_hex.size() > 0:
		if ItemMan.just_released:
			ItemMan.get_last_held().snap_position(hovered_hex[0].global_position)

func get_hovered_hex():
	if hovered_hex.size() > 0:
		return hovered_hex.back()
	return null

func on_mouse_entered(hex):
	item_hover_exit()	
	hovered_hex.append(hex)
	hex.set_interact_state(HexCell.INTERACT_STATE.hover)
	if ItemMan.is_currently_holding():
		check_valid_item_drop()
	
func on_mouse_exit(hex):
	hovered_hex.erase(hex)
	hex.set_interact_state(HexCell.INTERACT_STATE.idle)
	if ItemMan.is_currently_holding() and hovered_hex.size() == 0:
		item_hover_exit()

func check_valid_item_drop():
	var valid_drop = true
	var cur_hex = get_hovered_hex()
	var item = ItemMan.get_held_item() as Item
	var item_selected_hex = item.get_selected_hex()
	if cur_hex == null or item_selected_hex == null:
		return false
	# iterate for all cells in item
	for cell in item.shape.gridObjs:
		# travel from original inventory cell based on the current cell's coords
		var next_coords = cur_hex.coordinates + (cell.coordinates - item_selected_hex.coordinates)
		# check if in range
		if next_coords.x < 0 or next_coords.x >= grid().grid_array.dims[0] or next_coords.y < 0 or next_coords.y >= grid().grid_array.dims[1]:
			valid_drop = false
		# check if cell is free
		var next_hex = grid().get_hex(next_coords.x, next_coords.y)
		if next_hex != null and next_hex.cell_state == HexCell.CELL_STATE.empty:
			next_hex.set_interact_state(HexCell.INTERACT_STATE.select)
			itemover_hex.append(next_hex)
			
	if valid_drop == false:
		for itemover in itemover_hex:
			itemover.set_interact_state(HexCell.INTERACT_STATE.idle)
			
	return valid_drop

func item_hover_exit():
	for item in itemover_hex:
		item.set_interact_state(HexCell.INTERACT_STATE.idle)
	itemover_hex = []	
