extends "res://Encounters/Encounter.gd"

class ForageOdds:
	func _init(freq, _name):
		frequency = freq
		item_name = _name
		
	var frequency = 1
	var item_name
	
var forageMap = {}
var forageOdds = []
var forageItemPool = []
var slotList = []
var itemList = []

# flags
var debugSlots = false

# Called when the node enters the scene tree for the first time.
func _ready():
	init_slots()
	
	# init forage list with frequencies and scenes
	add_forage_item(1, "Banana")
	add_forage_item(1, "Watermelon")
	add_forage_item(1, "Mushroom")
	
	# init forage pool
	for item in forageOdds:
		for i in item.frequency:
			forageItemPool.append(item)
			
	spawn_items(rand_range(4, 6))

func init_slots():
	slotList = get_children()
	for slot in slotList:
		slot.visible = debugSlots

func add_forage_item(odds, item_name):
	forageOdds.append(ForageOdds.new(odds, item_name))
	forageMap[item_name] = load(get_item_path(item_name))

func get_item_path(item_name):
	return "res://Item/" + item_name + "/" + item_name + ".tscn"
	
func get_slots(num):
	slotList.shuffle()
	if num <= slotList.size():
		return slotList.slice(0, num)
	print("WARNING: Asking for more slots that exists!")
	return slotList 

func spawn_items(num):
	var slots = get_slots(num)
	for i in num:
		var new_item = get_random_item_from_pool()
		new_item.global_position = slots[i].global_position
		itemList.append(new_item)
		add_child(new_item)

func get_random_item_from_pool():
	var index = rand_range(0, forageItemPool.size())
	var item_obj = forageMap[forageItemPool[index].item_name]
	return item_obj.instance()
	
func clear_encounter():
	for item in itemList:
		if item.stored == true:
			remove_child(item)
			Ingame.add_child(item)
	.clear_encounter()
