/// @description Tooltip & Slot Keybinds

// Create hover state for each inventory slot
for (var i = 0; i < global.total_slots; i ++) {
	// Initial slot positions
	x_pos = start_width + vw;
	y_pos = vh - sprite_height + start_height;
	
	// Slot width calculations
	gap_between_slots = (i * gap) + (item_width * i);
	
	// Detect if cursor is hovering over a slot
	if point_in_rectangle(mouse_x, mouse_y, x_pos + gap_between_slots, y_pos, x_pos + gap_between_slots + item_width, y_pos + item_height) {
		slot_hover = i;
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