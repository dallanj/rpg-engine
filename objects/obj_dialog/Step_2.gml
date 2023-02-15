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
				// Update global inventory array with item slots
				UpdateInventoryArray();
				var item = global.items[data[text_current][4][i][1][0]];
				// Return an open slot in the inventory
				item.slot = GetOpenInventorySlot();
				item.quantity = data[text_current][4][i][1][1];
				ds_list_add(global.inventory, item);
				
			} else {
				data[text_current][4][i][0](data[text_current][4][i][1]);
			}
			
			
		}
		quest_complete = true;
	}
}


