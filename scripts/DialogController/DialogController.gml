/**
* Unlock dialog scripts for npc or items
*
* @param data (array)
*
* @return void
*/
function unlockDialog(data) {
	var result = false;
	
	if (data != noone) {
		with(data[1]) {
			obj_data.dialog_current = data[2];
			result = true;
		}
	}
	
	return result;
};

/**
* Exit or skip to the next script or choice selection in the dialog
*
* @return void
*/
function skipDialog() {
	// Length of the dialog script string
	var length = string_length(test[text_current]);
	
	// Set current character being printed in the script string to length of the string
	if (char_current < length) {
		char_current = length;
	} else {
		// Jump to next dialog script
		text_current += 1;
		if (text_current > text_last){
			// Destroy dialog box if there is no more dialog scripts
			instance_destroy(self);
		} else {
			// Choice based dialog
			if (test[text_current] == noone) {
				if (data[text_current][5] == noone) {
					instance_destroy(self);	
				} else {
					// Enabled choice selection
					display_choices = true;
				}
			} else {
				// Normal dialog script
				test[text_current] = string_wrap(test[text_current], text_width);
				char_current = 0;
			}
		}
	}
	
	return;
};

/**
* Run multiple functions after excuting a dialog script
*
* @param data (array)
*
* @return boolean
*/
function runDialogScript(data) {
	if (!is_array(data)) {
		return false;	
	}
	
	// Run multiple functions from the dialog script data
	for (var i = 0; i < array_length(data); i++) {	
		switch (data[i][0]) {
			case "startQuest":
				if (!data[i][2]) {
					// Did the script run successfully
					var result = startQuest(data[i]);
				
					if (result) {
						data[i][2] = true;
						StoreAlert("startQuest", data[i]);	
					}
				}
			break;
			case "completeQuest":
				if (!data[i][2]) {
					// Did the script run successfully
					var result = completeQuest(data[i]);
				
					if (result) {
						// Update the scripts use status to true
						data[i][2] = true;
						//StoreAlert("completeQuest", data[i]);	
					}
				}
			break;
			case "unlockDialog":
				if (!data[i][3]) {
					// Did the script run successfully
					var result = unlockDialog(data[i]);
					
					if (result) {
						// Update the scripts use status to true
						data[i][3] = true;
						StoreAlert("unlockDialog", data[i][1]);
					}
				}
			break;
			case "currency":
				if (!data[i][2]) {
					// Did the script run successfully
					var result = updateCurrency(data[i][1]);
					
					if (result) {
						// Update the scripts use status to true
						data[i][2] = true;
						StoreAlert("currency", data[i][1]);
					}
				}
			break;
			case "inventory":
				if (!data[i][2]) {
					// Did the script run successfully
					var result = unlockInventorySlots(data[i][1]);
					
					// Update the scripts use status to true
					data[i][2] = true;
						
					if (result > 0) {
						StoreAlert("inventory", result);
					}
				}
			break;
			case "reputation":
				if (!data[i][2]) {
					// Did the script run successfully
					var result = updateReputation(data[i][1]);
					
					if (result) {
						// Update the scripts use status to true
						data[i][2] = true;
						StoreAlert("reputation", data[i][1]);
					}
				}
			break;
			case "items":
				for (var items = 0; items < array_length(data[i][1]); items++) {
					if (!data[i][1][items].rewarded) {
						// Has the item been awarded to the player
						var awarded = updateInventory(data[i][1][items].item, data[i][1][items].quantity);
							
						if (!awarded) {
							// Add item to the npc's unclaimed rewards for the player to claim later
							var unclaimed_reward = {
								item: data[i][1][items].item,
								quantity: data[i][1][items].quantity,
								rewarded: false
							}
							array_push(data[i][2].obj_data.unclaimed_rewards,unclaimed_reward);
							
							// Alert user of unclaimed reward
							StoreAlert("unclaimedRewards", data[i][2]);
						} else {
							// Alert user of rewarded item
							StoreAlert("items",data[i][1][items].item);
						}
						
						data[i][1][items].rewarded = true;
					}
				}
			break;
		}
	}
	
	return true;
}