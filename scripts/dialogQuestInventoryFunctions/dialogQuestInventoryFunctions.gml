/**
* Unlock dialog scripts for npc or items
*
* @param data (array)
*
* @return void
*/
function unlockDialog(data) {
	if (data != noone) {
		with(data[1]) {
			obj_data.dialog_current = data[2];
		}
	}
	
	return;
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
* Increase currency by an amount
*
* @param amount (int)
*
* @return boolean
*/
function updateCurrency(amount) {
	if (is_undefined(global.currency) || !is_real(amount)) {
		return false;
	}
	
	global.currency += amount;
	return true;
};

/**
* Unlock a number of inventory slots
*
* @param amount (int)
*
* @return boolean|int
*/
function unlockInventorySlots(amount) {
	var rewarded = 0;
	
	// Get remaining locked inventory slots
	var locked_slots = global.total_slots - global.unlocked_slots;
	
	// Return if there are no more locked inventory slots
	if (locked_slots <= 0) {
		return rewarded;
	}
	
	// Set amount based on amount of unlockable inventory slots left
	if (locked_slots >= amount) {
		rewarded = amount;
	} else {
		rewarded = locked_slots;
	}
	
	// Update player's inventory slot space
	obj_player.player.inventory_slots += rewarded;
	global.unlocked_slots += rewarded;
	
	// Return number of inventory slots unlocked
	return rewarded;
};

/**
* Increase reputation by an amount
*
* @param amount (int)
*
* @return boolean
*/
function updateReputation(amount) {
	if (is_undefined(global.reputation) || !is_real(amount)) {
		return false;
	}
	
	global.reputation += amount;
	return true;
};

/**
* Add item to player's inventory
*
* @param item (int/object)
* @param quantity (int)
*
* @return boolean
*/
function updateInventory(item, quantity) {
	var inventory_size = ds_list_size(global.inventory);
	
	// Has item been awarded to the player
	var rewarded = false;
	
	// Update global inventory array with item slots
	UpdateInventoryArray();
	
	// Return an open slot in the inventory
	var open_slot = GetOpenInventorySlot();
							
	// Existing inventory item
	var inv_item;
							
	// Add non stackable item to an empty inventory slot
	if (!is_undefined(open_slot) && !item.stackable) {
		item.slot = open_slot;
		ds_list_add(global.inventory, item);
		rewarded = true;
	}
							
	// If the item is stackable
	if (item.stackable) {
		// Stackable item is already in the player's inventor
		var in_inventory = false;
								
		// Iterate through player's inventory
		for (var slot = 0; slot < inventory_size; slot ++) {
			// Get the item in the current slot being checked
			inv_item = ds_list_find_value(global.inventory, slot);
			
			// Break the loop if the stackable item is in the inventory already
			if (!is_undefined(inv_item) && inv_item.name == item.name) {
				in_inventory = true;
				break;
			}
		}
								
		// Update existing item's quantity in the inventory
		if (in_inventory) {
			inv_item.quantity += quantity;
			rewarded = true;
		}
								
		// Insert stackable item to an empty inventory slot
		if (!in_inventory && !is_undefined(open_slot)) {
			item.quantity = quantity;
			item.slot = open_slot;
			ds_list_add(global.inventory, item);
			rewarded = true;
		}
	}
	
	return rewarded;
};

/**
* Begin a quest
*
* @param data (array)
*
* @return boolean
*/
function startQuest(data) {
	if (!is_array(data) || !is_string(data[1]) || is_undefined(global.quests[$ data[1]])) {
		return false;
	}
	
	// Return if player has already started the quest
	if (global.quests[$ data[1]].started) {
		return false;
	}
	
	
	global.quests[$ data[1]].started = true;
	return true;
};

/**
* Return all quests by a specific npc or item
*
* @param npc (int/object)
*
* @return array
*/
function getQuestsByNpc(npc) {
	var quests = [];
	var keys = variable_struct_get_names(global.quests);
	
	// Find quests by NPC
	for (var quest = 0; quest < array_length(keys); quest++) {
		var current_key = keys[quest];
		if (global.quests[$ current_key].npc == npc) {
			array_push(quests, global.quests[$ current_key]);	
		}
	}
	
	return quests;
};

/**
* Claim unclaimed rewards from an npc or item
*
* @param items (array)
*
* @return void
*/
function claimRewards(items) {
	// Try to claim all unclaimed rewards
	for (var item = 0; item < array_length(items); item++) {
		if (!items[item].rewarded) {
			// Has the item been awarded to the player
			var rewarded = updateInventory(items[item].item, items[item].quantity);
							
			// Update unclaimed item as rewarded if the item has been awarded
			if (rewarded) {
				items[item].rewarded = true;
				// TODO: Alert player of dialog unlocks
			}
		} else {
			// Remove claimed reward from npc's unclaimed rewards
			array_delete(items, item, 1);
		}
	}
	
	return;
};

/**
* Claim unclaimed rewards from a previously completed quest
*
* @param quests (array)
*
* @return void
*/
function claimQuestRewards(quests) {
	// Check if quest is completed
	for (var quest = 0; quest < array_length(quests); quest++) {
		if (quests[quest].completed) {	
			// Check if any items have not been rewarded yet
			for (var reward = 0; reward < array_length(quests[quest].rewards.items); reward++) {
				if (!quests[quest].rewards.items[reward].rewarded) {
					// Has the item been awarded to the player
					var rewarded = updateInventory(quests[quest].rewards.items[reward].item, quests[quest].rewards.items[reward].quantity);
							
					// Update quest item as rewarded if the item has been awarded
					if (rewarded) {
						quests[quest].rewards.items[reward].rewarded = true;
						// TODO: Alert player of dialog unlocks
					}
				}
			}
		}
	}
	
	return;
};

/**
* Return the amount of unclaimed rewards still owed from completing a quest
*
* @param quests (array)
*
* @return int
*/
function hasUnclaimedQuestRewards(quests) {
	// Number of unclaimed rewards
	var num_of_rewards = 0;
	
	// Find an open slot
	var open_slot = GetOpenInventorySlot();
	
	// Don't reward player if there is no open inventory slot
	if (is_undefined(open_slot)) {
		// Check if quest is completed
		for (var quest = 0; quest < array_length(quests); quest++) {
			if (quests[quest].completed) {	
				// Check if any items have not been rewarded yet
				for (var item = 0; item < array_length(quests[quest].rewards.items); item++) {
					if (!quests[quest].rewards.items[item].rewarded) {
						num_of_rewards++;
					}
				}
			}
		}
	}
	
	return num_of_rewards;
};

/**
* Return the amount of unclaimed rewards still owed from an npc or item
*
* @param items (array)
*
* @return int
*/
function hasUnclaimedRewards(items) {
	// Number of unclaimed rewards
	var num_of_rewards = 0;
	
	// Find an open slot
	var open_slot = GetOpenInventorySlot();
	
	// Don't reward player if there is no open inventory slot
	if (is_undefined(open_slot)) {
		// Check if quest is completed
		for (var item = 0; item < array_length(items); item++) {
			if (!items[item].rewarded) {
				num_of_rewards++;
			}
		}
	}
	
	return num_of_rewards;
};

/**
* Completes a quest and rewards the player
*
* @param data (array)
*
* @return void
*/
function completeQuest(data) {
	var quest = global.quests[$ data[1]];
	
	// Update quest to completed
	quest.completed = true;
	
	// List of the quest's rewards
	var rewards = quest.rewards;
	
	// Iterate over each key in the quest_list struct
	var keys = variable_struct_get_names(rewards);
	
	for (var i = 0; i < array_length(keys); i++) {
	    // Get the current key
	    var current_key = keys[i];
		
		// Reward the player for quest completion
		switch (current_key) {
			case "currency":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						// Has currency been awarded to the player
						var rewarded = updateCurrency(rewards[$ current_key].quantity);
						
						// Update quest item as rewarded if currency has been awarded to the player
						if (rewarded) {
							rewards[$ current_key].rewarded = true;
							// TODO: Alert player of reward
						}
					}
				}
			break;
			case "inventory":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						// How many slots have been unlocked
						var rewarded = unlockInventorySlots(rewards[$ current_key].quantity);
						
						// Update quest item as rewarded if any inventory slots have been unlocked
						if (rewarded > 0) {
							rewards[$ current_key].rewarded = true;
							// TODO: Alert player of reward
						}
					}
				}
			break;
			case "reputation":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						// Has reputation been awarded to the player
						var rewarded = updateReputation(rewards[$ current_key].quantity);
						
						// Update quest item as rewarded if reputation has been awarded to the player
						if (rewarded) {
							rewards[$ current_key].rewarded = true;
							// TODO: Alert player of reward
						}
					}
				}
			break;
			case "items":
				if (rewards[$ current_key] != noone) {
					for (var items = 0; items < array_length(rewards[$ current_key]); items++) {
						if (!rewards[$ current_key][items].rewarded) {
							// Has the item been awarded to the player
							var rewarded = updateInventory(rewards[$ current_key][items].item, rewards[$ current_key][items].quantity);
							
							// Update quest item as rewarded if the item has been awarded
							if (rewarded) {
								rewards[$ current_key][items].rewarded = true;
								// TODO: Alert player of reward
							}
						}
					}
				}
			break;
		}
	}
	
	return;
};

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
						// TODO: Alert player of quest start	
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
						// TODO: Alert player of quest completion	
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
						// TODO: Alert player of dialog unlocks
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
						// TODO: Alert player of dialog unlocks
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
						// TODO: Alert player of dialog unlocks
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
						// TODO: Alert player of dialog unlocks
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
						} else {
							// TODO: Alert player of reward
							// Update item as rewarded if the item has been awarded or added to npc's unclaimed rewards
							
						}
						
						data[i][1][items].rewarded = true;
					}
				}
			break;
		}
	}
	
	return true;
}