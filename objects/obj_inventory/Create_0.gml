/// @description Init Inventory

/*
	First starting slot x postion is 20 pixels from left
	Each inventory slot is 56x56px
	Space between each slot is 8px wide
*/

// Create inventory
global.inventory = ds_list_create();
global.total_slots = 9;
global.unlocked_slots = obj_player.player.inventory_slots;

// Create inventory array
UpdateInventoryArray();

// Inventory sprite dimensions
inventory_width = sprite_get_width(spr_inventory);
inventory_height = sprite_get_height(spr_inventory);

// Inventory Fonts
quantity_font = font_add("Gaegu-Regular.ttf", 14, false, false, 32, 128);
desc_font = font_add("Fredoka-SemiBold.ttf", 24, false, false, 32, 128);

// Starting items for player
updateInventory(new Toad(), 1);

// Slot positions
slot_pos = 0; // Keybinds and mouse scroll
slot_hover = 0; // Mouse hover over slot

// Viewport positions
vw = (view_xport[0] + view_wport[0] / 2) - (inventory_width / 2);
vh = view_yport[0] + view_hport[0] / 2 + 250;

// Item sprite dimensions
item_width = 56;
item_height = 56;

// Inventory HUD sprite starting positions (PX)
start_width = 20;
start_height = 18;
gap = 8;
text_x_pos = 0;
text_y_pos = 0;
gap_between_slots = 0;
x_pos = 0;
y_pos = 0;

// Inventory selector
selector_start_width = 16;
selector_start_height = 15;

// Hover tooltip
tool_tip = false;
tool_tip_x = 0;
tool_tip_y = 0;

// Fade effect
alpha = 0;
max_alph = 1;
alph_timer = .05;

// Used to remove drawn tooltip sprite
alarm[0] = 1;