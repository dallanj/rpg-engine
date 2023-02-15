// Update global inventory array with item slots
function UpdateInventoryArray() {
	// Reset inventory array positions
	global.inventory_array = array_create(global.total_slots, false);
	
	for (var i = 0; i < global.total_slots; i ++) {
		var item = ds_list_find_value(global.inventory, i);
	
		if (item) {
			// Update inventory array with the item slot position
			global.inventory_array[item.slot - 1] = item;	
		}
	}
}

// Return an open slot in the inventory
function GetOpenInventorySlot() {
	for (var i = 0; i < global.total_slots; i++) {
		if (global.inventory_array[i] == 0) {
			return i + 1;
		}
	}
}

// Drop item from inventory
function DropItem(xx, yy, instance, item) {
	// Get index of item within the inventory list
	var index = ds_list_find_index(global.inventory, item);
	
	// Remove item from inventory list
	ds_list_delete(global.inventory, index);
	
	// Create object instance at players position
	var new_instance = instance_create_layer(xx, yy, instance, item.object);
	
	if (item.stackable) {
		// Set new instance quantity to # of quantity dropped
		with (new_instance) {
			quantity = item.quantity;
		}
	}
	
	// Update global inventory array with item slots
	UpdateInventoryArray();
}

// Add item to inventory
function AddItem(object) {
	var inventory_size = ds_list_size(global.inventory);
	var item, open_slot;

	// Update global inventory array with item slots
	UpdateInventoryArray();

	// Return an open slot in the inventory
	open_slot = GetOpenInventorySlot();

	// Items that are not stackable
	if (inventory_size < global.total_slots && !object.item.stackable) {
		object.item.slot = open_slot;
		ds_list_add(global.inventory, object.item);
		instance_destroy(object);
	}

	// Items that are stackable
	if (object.item.stackable) {
		
		var in_inventory = false;
		// Iterate through inventory
		for (var i = 0; i < inventory_size; i ++) {
			// Get inventory item object
			item = ds_list_find_value(global.inventory, i);
			
			// If inventory object name is the same as the item we are picking up
			if (item.name == object.item.name) {
				if (quantity > 1) {
					item.quantity += quantity;
					in_inventory = true;
				} else {
					item.quantity += object.quantity;
					in_inventory = true;
				}
			}
		}
	
		// If item is in inventory
		if (in_inventory) {
			instance_destroy(object);
		} else if (!in_inventory && inventory_size < global.total_slots) {
			// If item is not in the inventory and slots are open
			if (quantity > 1) {
				object.item.quantity = quantity;
			} else {				
				object.item.quantity = object.quantity;
			}
			object.item.slot = open_slot;
			ds_list_add(global.inventory, object.item);
			instance_destroy(object);
		}
	}
}

// Draw the inventory array for testing purposes
function DrawInventoryArray() {
	for (var i = 0; i < global.total_slots; i++) {
		var slot_position = string("Slot ") + string(i + 1) + string(": ");
		draw_set_color(c_black);
		if (global.inventory_array[i] == 0) {
			draw_text(8, 24 * (i+1), string(slot_position));
		} else {
			var item_name = global.inventory_array[i].name;
			var item_slot = global.inventory_array[i].slot;
			draw_text(8, 24 * (i+1), string(slot_position) + string(item_name) + string(" ") + string(item_slot));
		}
	}
}