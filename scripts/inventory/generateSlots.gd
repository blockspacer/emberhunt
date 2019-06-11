# Copyright 2019 Emberhunt Team
# https://github.com/emberhunt
# Licensed under the GNU General Public License v3.0 or later
# SPDX-License-Identifier: GPL-3.0-or-later

extends GridContainer

onready var stats = Global.charactersData[Global.charID]

var special_slots = 4

func _ready():
	# Generate columns for gridContainer
	columns = int((get_viewport().size.x-110)/66.0)-1
	# Generate slots
	for slot in range(stats.level+20-special_slots):
		var scene = preload("res://scenes/inventory/InventorySlot.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name(str(slot+special_slots))
		add_child(scene_instance)
	# Add items to slots
	var items = stats['inventory']
	for item in items.keys():
		var scene_instance = preload("res://scenes/inventory/Item.tscn").instance()
		var on_special_slot = false
		if int(item) <= 3:
			on_special_slot = true
			scene_instance.rect_global_position = get_node("../../"+item).rect_global_position+Vector2(8,8)
		else:
			scene_instance.rect_global_position = Vector2(((int(item)-special_slots)%columns)*66+8,int((int(item)-special_slots)/float(columns))*66+8)
		scene_instance.itemID = items[item]["item_id"]
		scene_instance.quantity = items[item]["quantity"]
		scene_instance.slotID = int(item)
		if on_special_slot:
			get_node("../../ItemsInSpecialSlots").add_child(scene_instance)
		else:
			get_node("../Items").add_child(scene_instance)