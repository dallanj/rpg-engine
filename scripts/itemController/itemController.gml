// Update global inventory array with item slots
function updateInventoryArray() {
	// Reset inventory array positions
	global.inventory_array = array_create(global.unlocked_slots, false);
	
	for (var i = 0; i < global.unlocked_slots; i ++) {
		var item = ds_list_find_value(global.inventory, i);
	
		if (item) {
			// Update inventory array with the item slot position
			global.inventory_array[item.slot - 1] = item;	
		}
	}
}

// Return an open slot in the inventory
function getOpenInventorySlot() {
	for (var i = 0; i < global.unlocked_slots; i++) {
		if (global.inventory_array[i] == 0) {		
			return i + 1;
		}
	}
}

// Drop item from inventory
function dropItem(xx, yy, instance, inv_item) {
	// Get index of item within the inventory list
	var index = ds_list_find_index(global.inventory, inv_item);
	
	// Remove item from inventory list
	ds_list_delete(global.inventory, index);
	
	// Create object instance at players position
	var new_instance = instance_create_layer(xx, yy, instance, inv_item.object);
	
	if (inv_item.stackable) {
		// Set new instance quantity to # of quantity dropped
		with (new_instance) {
			item.quantity = inv_item.quantity;
		}
	}
	
	// Update global inventory array with item slots
	updateInventoryArray();
}

// Add item to inventory
function addItem(object) {
	var inventory_size = ds_list_size(global.inventory);
	var item, open_slot;

	// Update global inventory array with item slots
	updateInventoryArray();

	// Return an open slot in the inventory
	open_slot = getOpenInventorySlot();
	
	// Item added to inventory
	var result = false;

	// Items that are not stackable
	if (inventory_size < global.unlocked_slots && !object.item.stackable) {
		object.item.slot = open_slot;
		ds_list_add(global.inventory, object.item);
		result = true;
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
				item.quantity += object.item.quantity;
				in_inventory = true;
				result = true;
			}
		}
	
		// If item is in inventory
		if (!in_inventory && inventory_size < global.unlocked_slots) {
			// If item is not in the inventory and slots are open
			object.item.slot = open_slot;
			ds_list_add(global.inventory, object.item);
			result = true;
		}
		
	}
	
	if (result) {
		storeAlert(Action.UpdateInventory, object.item);
		instance_destroy(object);
	}
}

// Draw the inventory array for testing purposes
function drawInventoryArray() {
	for (var i = 0; i < global.unlocked_slots; i++) {
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