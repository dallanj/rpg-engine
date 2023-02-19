/**
* Increase currency by an amount
*
* @param amount (int)
*
* @return boolean
*/
function updateCurrency(amount) {
	if (is_undefined(global.currency) || !is_real(amount)) {
		return false;
	}
	
	global.currency += amount;
	return true;
};

/**
* Unlock a number of inventory slots
*
* @param amount (int)
*
* @return boolean|int
*/
function unlockInventorySlots(amount) {
	var rewarded = 0;
	
	// Get remaining locked inventory slots
	var locked_slots = global.total_slots - global.unlocked_slots;
	
	// Return if there are no more locked inventory slots
	if (locked_slots <= 0) {
		return rewarded;
	}
	
	// Set amount based on amount of unlockable inventory slots left
	if (locked_slots >= amount) {
		rewarded = amount;
	} else {
		rewarded = locked_slots;
	}
	
	// Update player's inventory slot space
	obj_player.player.inventory_slots += rewarded;
	global.unlocked_slots += rewarded;
	
	// Return number of inventory slots unlocked
	return rewarded;
};

/**
* Increase reputation by an amount
*
* @param amount (int)
*
* @return boolean
*/
function updateReputation(amount) {
	if (is_undefined(global.reputation) || !is_real(amount)) {
		return false;
	}
	
	global.reputation += amount;
	return true;
};

/**
* Add item to player's inventory
*
* @param item (int/object)
* @param quantity (int)
*
* @return boolean
*/
function updateInventory(item, quantity) {
	var inventory_size = ds_list_size(global.inventory);
	
	// Has item been awarded to the player
	var rewarded = false;
	
	// Update global inventory array with item slots
	UpdateInventoryArray();
	
	// Return an open slot in the inventory
	var open_slot = GetOpenInventorySlot();
							
	// Existing inventory item
	var inv_item;
							
	// Add non stackable item to an empty inventory slot
	if (!is_undefined(open_slot) && !item.stackable) {
		item.slot = open_slot;
		ds_list_add(global.inventory, item);
		rewarded = true;
	}
							
	// If the item is stackable
	if (item.stackable) {
		// Stackable item is already in the player's inventor
		var in_inventory = false;
								
		// Iterate through player's inventory
		for (var slot = 0; slot < inventory_size; slot ++) {
			// Get the item in the current slot being checked
			inv_item = ds_list_find_value(global.inventory, slot);
			
			// Break the loop if the stackable item is in the inventory already
			if (!is_undefined(inv_item) && inv_item.name == item.name) {
				in_inventory = true;
				break;
			}
		}
								
		// Update existing item's quantity in the inventory
		if (in_inventory) {
			inv_item.quantity += quantity;
			rewarded = true;
		}
								
		// Insert stackable item to an empty inventory slot
		if (!in_inventory && !is_undefined(open_slot)) {
			item.quantity = quantity;
			item.slot = open_slot;
			ds_list_add(global.inventory, item);
			rewarded = true;
		}
	}
	
	return rewarded;
};
