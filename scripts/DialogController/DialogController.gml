/**
* Unlock dialog scripts for npc or items
*
* @param data (struct)
*
* @return void
*/
function unlockDialog(data) {
	var result = false;
	
	with(data.npc) {
		obj_data.dialog_current = data.dialog;
		result = true;
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
				if (data[text_current].choices == noone) {
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
* @param dialog_script (array)
*
* @return boolean
*/
function runDialogScript(dialog_script) {
	if (!is_array(dialog_script)) {
		return false;	
	}
	
	show_message(dialog_script);
	
	// Run multiple functions from the dialog script data
	for (var i = 0; i < array_length(dialog_script); i++) {
		var data = dialog_script[i]
		
		// Reward the player for quest completion
		if (!data.rewarded) {
			// Did the script run successfully
			var rewarded = false;
			
			// Type of reward and it's action
			var action = data.action;
			
			// Value of reward
			var value = data.value;
			
			// Data to be used for alert
			var alert_data = value;
			var alert_type = action;
			
			switch (action) {
				case Action.StartQuest:
					rewarded = startQuest(value);
					
					if (!rewarded) {
						break;
						
					}
				break;
				case Action.CompleteQuest:
					var quest = completeQuest(value);
					
					if (is_struct(quest)) {
						alert_data = quest;
						rewarded = true;
					}
				break;
				case Action.UnlockDialog:
					rewarded = unlockDialog(value);
					//show_message(rewarded);
					
					alert_data = value.npc.obj_data;
				break;
				case Action.UpdateCurrency:
					rewarded = updateCurrency(value);
				break;
				case Action.UnlockSlots:
					var amount = unlockInventorySlots(value);
					
					// Set the value of the reward to the number of slots unlocked
					if (amount > 0) {
						alert_data = amount;
						rewarded = true;
					}
				break;
				case Action.UpdateReputation:
					rewarded = updateReputation(value);
				break;
				case Action.UpdateInventory:
					// Has the item been awarded to the player
					var result = updateInventory(value.item); 
					
					if (!result) {
						// Add item to the npc's unclaimed rewards for the player to claim later
						var unclaimed_reward = {
							action: action,
							value: value.item,
							rewarded: false
						}
						
						var npc = value.npc.obj_data;
						alert_data = npc;
						alert_type = Action.UnclaimedRewards;
						
						// Item is now within the npc's unclaimed rewards for the player to claim later
						array_push(npc.unclaimed_rewards, unclaimed_reward);
					} else if (is_struct(result)) {
						alert_data = result;
					} else {
						alert_data = value.item;
					}
					
					rewarded = true;
				break;
			}
			
			// Update quest item as rewarded if the item has been awarded
			if (rewarded) {
				data.rewarded = true;
				storeAlert(alert_type, alert_data);
			}
		}
	}
	
	return true;
}