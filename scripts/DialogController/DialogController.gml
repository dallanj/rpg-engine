/**
* Unlock dialog scripts for npc or items
*
* @param request (struct)
*
* @return boolean
*/
function unlockDialog(request) {
	var result = false;
	
	with(request.npc) {
		obj_data.dialog_current = request.dialog;
		result = true;
	}
	
	return result;
};

/**
* Resets to variables back to original values
*
* @return void
*/
function resetDialogVariables() {
	before_scripts = false;
	after_scripts = false;
}

/**
* Switch from regular dialog to generic dialog
*
* @param request (struct)
*
* @return void
*/
function switchDialog(request) {
	var type = request.dialog_type;
	
	var genericDialog;
	
	// Object to be returned with updated values
	var response;
	
	if (request.npc_state != noone) {
		// If coming from an npc state memory event
		var npc_state = request.npc_state;
		response = npc_state.dialog;
		genericDialog = npc_state.generic_dialog;
	} else {
		// If coming from dialog instance
		response = self;	
		genericDialog = obj_data.generic_dialog;
	}
		
	switch (type) {
		case Action.NextDialogLine:
			// Switch to a specific line number using Action.NextDialogLine
			text_current = request.text_current;
		break;
		case Action.StartQuest:
		case Action.UnclaimedRewards:
			// Switch to generic dialog
			response.text_last = array_length(genericDialog[type]) - 1;
			for (var j = 0; j <= response.text_last; j++) {
				// Data to be used within the generic dialog script
				if (type == Action.UnclaimedRewards) {
					var generic_string = genericDialog[type][0].dialog;
					generic_string = string_replace(generic_string, "XX", string(request.dialog_data));
					genericDialog[type][0].dialog = generic_string;
				}
							
				// Set current dialog script to the generic dialog script
				response.data[j] = genericDialog[type][j];
				response.test[j] = genericDialog[type][j].dialog;
			}
			response.text_current = 0;
			response.char_current = 1;
			response.selected_choice = noone;
			
			// Fresh reset of variable values
			resetDialogVariables();
		break;
	}
	
	return;
}

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
		
		// Fresh reset of variable values
		resetDialogVariables();
	} else {
		var after_scripts_to_run = noone;
		
		// Get the scripts that need to run after text is displayed
		if (selected_choice != noone) {
			//show_message("RUN");
			after_scripts_to_run = data[text_current].choices[selected_choice].after;
		} else {
			after_scripts_to_run = data[text_current].after;
		}
		
		// Run the scripts that need to run after text is displayed
		if (after_scripts_to_run != noone) {
			after_scripts = runDialogScript(after_scripts_to_run);
		} else {
			after_scripts = true;
		}
		
		//show_message(after_scripts);
		
		if (after_scripts != false) {		
			// Set the next line in the dialog
			if (is_struct(after_scripts)) {
				switchDialog(after_scripts);		
			} else if (after_scripts) {		
				// Next line in the dialog
				text_current += 1;
			}
			
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
						selected_choice = noone;
						
						// Fresh reset of variable values
						resetDialogVariables();
					}
				} else {
					// Normal dialog script
					text_width = string_width(test[text_current]);
					test[text_current] = string_wrap(test[text_current], text_width);
					char_current = 1;
					selected_choice = noone;
					
					// Fresh reset of variable values
					resetDialogVariables();
				}
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
	
	var successful = true;
	
	// Run multiple functions from the dialog script data
	for (var i = 0; i < array_length(dialog_script); i++) {
		var data = dialog_script[i];
		
		// If player should be alerted
		var should_alert = true;
		
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
						successful = {
							dialog_type: action,
							dialog_data: noone,
							npc_state: noone,
						};
					}
				break;
				case Action.CompleteQuest:
					var quest = completeQuest(value);
					
					if (is_struct(quest)) {
						alert_data = quest;
						rewarded = true;
					}
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
						
						// Store unclaimed rewards in array to be returned
						if (!is_struct(successful)) {
							successful = {
								dialog_type: Action.UnclaimedRewards,
								dialog_data: 0,
								npc_state: noone,
							};
						}
						
						successful.dialog_data += 1;
						
					} else if (is_struct(result)) {
						alert_data = result;
					} else {
						alert_data = value.item;
					}
					
					rewarded = true;
				break;
				case Action.UnlockDialog:
					rewarded = unlockDialog(value);
					
					alert_data = value.npc.obj_data;
				break;
				// Dialog scripts that run after and never update rewarded
				case Action.NextDialogLine:
					rewarded = should_alert = false;
					
					// Return the next dialog line to run
					successful = {
						dialog_type: action,
						text_current: value.dialog,
						npc_state: noone,
					};
				break;
				case Action.EndDialog:
					rewarded = should_alert = false;
					
					// End the dialog at the current line
					instance_destroy(self);
				break;
			}
			
			// Update quest item as rewarded if the item has been awarded
			if (rewarded) {
				data.rewarded = true;
				
				if (should_alert) storeAlert(alert_type, alert_data);
			} else {
				if (is_struct(successful)) break;
				successful = false;
				break;
			}
		}
	}
	
	return successful;
}