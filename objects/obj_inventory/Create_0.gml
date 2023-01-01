/// @description Init Inventory

/*
	First starting slot x postion is 20 pixels from left
	Each inventory slot is 56x56px
	Space between each slot is 8px wide
*/

// Create inventory
global.inventory = ds_list_create();
ds_list_add(global.inventory, global.items[ITEM.GHOST]);
slot_pos = 0;
slot_hover = 0;
global.total_slots = 9;

// Viewport positions
vw = x - sprite_get_xoffset(sprite_index) - sprite_width / 2;
vh = camera_get_view_height(view_camera[0]);

// Item sprite dimensions
item_width = 56;
item_height = 56;

// Inventory HUD sprite starting positions (PX)
start_width = 20;
start_height = 18;
gap = 8;
x_pos = 0;
y_pos = 0;
text_x_pos = 0;
text_y_pos = 0;
gap_between_slots = 0;

// Inventory selector
selector_start_width = 16;
selector_start_height = 15;

// Hover tooltip
tool_tip = false;
tool_tip_x = 0;
tool_tip_y = 0;
alarm[0] = 1; // Used to remove drawn tooltip sprite