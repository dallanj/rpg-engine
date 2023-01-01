/// @description 

var inventory_size = ds_list_size(global.inventory);

// Items that are not stackable
if (inventory_size < global.total_slots && !other.item.stackable) {
	ds_list_add(global.inventory, other.item);
	instance_destroy(other);
}

// Items that are stackable
if (other.item.stackable) {
	var in_inventory = false;
	// Iterate through inventory
	for (var i = 0; i < inventory_size; i ++) {
		// Get inventory item object
		var item = ds_list_find_value(global.inventory, i);
			
		// If inventory object name is the same as the item we are picking up
		if (item.name == other.item.name) {
			item.quantity++;
			in_inventory = true;
		}
	}
	
	// If item is in inventory
	if (in_inventory) {
		instance_destroy(other);
	} else if (!in_inventory && inventory_size < global.total_slots) {
		// If item is not in the inventory and slots are open
		ds_list_add(global.inventory, other.item);
		instance_destroy(other);
	}
}