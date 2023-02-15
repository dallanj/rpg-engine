/// @description Insert description here
// You can write your code in this editor
// Unlock dialog
if (text_current <= text_last) {
	if (data[text_current][3] != noone) {
	//[obj_dialog_daniel_journal, "item", 1]
	//show_message("GASD: " + string(data[text_current][3]));
		unlockDialog(data[text_current][3]);
	}
	
	if (data[text_current][4] != noone && !quest_complete) {
		for (i = 0; i < array_length(data[text_current][4]); i++) {
			if (is_array(data[text_current][4][i][1])) {
				//AddItem(data[text_current][4][i][1][0], data[text_current][4][i][1][1], true);
				//ds_list_add(global.inventory, global.items[ITEM.SHELL]);
				// Return an open slot in the inventory
				//var open_slot = GetOpenInventorySlot();
				show_message(ds_list_size(global.inventory));
				ds_list_replace(global.inventory, 2, global.items[ITEM.SHELL]);
				
			} else {
				data[text_current][4][i][0](data[text_current][4][i][1]);
			}
			
			
		}
		quest_complete = true;
	}
}


