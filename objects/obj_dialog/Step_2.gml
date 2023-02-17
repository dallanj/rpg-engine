/// @description Insert description here
// You can write your code in this editor
// Unlock dialog
if (text_current <= text_last) {
	if (data[text_current][3] != noone) {
		for (j = 0; j < array_length(data[text_current][3]); j++) {
						
			switch (data[text_current][3][j][0]) {
				case "startQuest":
					startQuest(data[text_current][3][j]);
				break
				case "completeQuest":
					completeQuest(data[text_current][3][j]);
				break;
				case "unlockDialog":
					unlockDialog(data[text_current][3][j]);
				break;
			}
		}
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


