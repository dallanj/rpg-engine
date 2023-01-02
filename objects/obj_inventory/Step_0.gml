/// @description Tooltip & Slot Keybinds

// Update global inventory array with item slots
UpdateInventoryArray();

// Create hover state for each inventory slot
for (var i = 0; i < global.total_slots; i ++) {
	
	// Get slot item from inventory array
	var item = global.inventory_array[i];
	
	if (item == 0) {
		continue;	
	}
	
	var item_slot = item.slot - 1;
	
	// Slot width calculations
	gap_between_slots = (item_slot * gap) + (item_width * item_slot);
	
	// Detect if cursor is hovering over a slot
	if point_in_rectangle(mouse_x, mouse_y, x_pos + gap_between_slots, y_pos, x_pos + gap_between_slots + item_width, y_pos + item_height) {
		slot_hover = item_slot;
	    // Set hover tooltip to true
		tool_tip = true;
		tool_tip_x = x_pos + gap_between_slots;
		tool_tip_y = y_pos;
	}
}

// Inventory slot keybinds (1-9)
for (var i = 0; i < global.total_slots; i ++) {
	if keyboard_check(ord(i + 1)) {
		slot_pos = i;
	}
}