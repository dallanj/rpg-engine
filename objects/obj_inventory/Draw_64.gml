/// @description Draw Inventory HUD
if (!global.dialog_exists) {
	// Draw inventory HUD
	draw_sprite_ext(spr_inventory, 0, vw, vh, 1, 1, 0, -1, 0.5);

	// Text colors
	draw_set_color(c_grey);
	draw_set_font(font_inventory);

	// Draw inventory selector
	x_pos = selector_start_width + vw;
	y_pos = vh + selector_start_height;
	var selector_gap_between_slots = (slot_pos * gap) + (slot_pos * item_width);
	draw_sprite(spr_inventory_selected, 0, x_pos + selector_gap_between_slots, y_pos);

	// Draw slot keybinds
	for (var i = 0; i < global.total_slots; i ++) {
		gap_between_slots = (i * gap) + (item_width * i);
		text_x_pos = x_pos + gap_between_slots;
		text_y_pos = y_pos - 2; // 4
		draw_text(text_x_pos, text_y_pos, i + 1);
	}

	// Iterate through each item in inventory
	for (var i = 0; i < global.total_slots; i ++) {
		// Item data
		var item = global.inventory_array[i];
	
		if (!item) {
			continue;
		}
	
		var item_slot = item.slot - 1;
	
		// Initial slot positions
		x_pos = start_width + vw;
		y_pos = vh + start_height;
	
		// Slot width calculations
		gap_between_slots = (item_slot * gap) + (item_width * item_slot);
	
		// Draw each item in slots
		draw_sprite(item.inv_sprite, 0, x_pos + gap_between_slots, y_pos);
	
		// Draw quantity if item is stackable
		if (item.stackable) {
			text_x_pos = x_pos + gap_between_slots + item_width - gap;
			text_y_pos = y_pos + (item_height / 2) + 4; // 10
		
			// Item quantity
			DrawTextOutlined(text_x_pos, text_y_pos, c_black, c_white, item.quantity);
		}
	}

	// Draw tooltip for items within inventory slots
	if (tool_tip) {
		// Item data
		var item = global.inventory_array[slot_hover];
	
		// Tooltip dimensions
		var tooltip_height = sprite_get_height(spr_inv_tooltip);
		var tooltip_x_pos = tool_tip_x - (item_width * 2);
		var tooltip_y_pos = tool_tip_y - tooltip_height - (gap * 2);
		var tooltip_text_x_pos = tooltip_x_pos + 20;
		var tooltip_text_y_pos = tooltip_y_pos + 25;
	
		// Draw tooltip if there is an item currently in the slot
		if (item) {
			// Draw tooltip container
			draw_sprite(spr_inv_tooltip, 0, tooltip_x_pos, tooltip_y_pos);
		
			// Name of item and quantity
			draw_set_font(font_tool_tip);
			var tooltip_title = item.stackable ? string(item.name) + " x" + string(item.quantity) : string(item.name);
			DrawTextOutlined(tooltip_text_x_pos, tooltip_text_y_pos, c_black, c_white, tooltip_title);
		
			// Description of item
			draw_set_font(font_inventory);
			DrawTextOutlined(tooltip_text_x_pos, tooltip_text_y_pos + 75, c_black, c_white, string(item.slot));
		
		}
	}
}