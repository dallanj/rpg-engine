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
* Increase currency by an amount
*
* @param amount (int)
*
* @return void
*/
function updateCurrency(amount) {
	global.currency += amount;
	
	return;
};

/**
* Unlock a number of inventory slots
*
* @param amount (int)
*
* @return void
*/
function unlockInventorySlots(amount) {
	obj_player.player.inventory_slots += amount;
	global.unlocked_slots = obj_player.player.inventory_slots;
	
	return;
};

/**
* Increase reputation by an amount
*
* @param amount (int)
*
* @return void
*/
function updateReputation(amount) {
	global.reputation += amount;
	
	return;
};

/**
* Add item to inventory
*
* @param item (int/object)
* @param add (boolean)
* @param quantity (int)
*
* @return void
*/
function updateInventory(item, add, quantity) {
	AddItem(item, quantity, true);
	
	return;
};

/**
* Begin a quest
*
* @param data (array)
*
* @return void
*/
function startQuest(data) {
	global.quests[$ data[1]].started = true;
	
	return;
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
* Claim unclaimed rewards from a previously completed quest
*
* @param quests (array)
*
* @return void
*/
function claimRewards(quests) {
	// Find an open slot
	var open_slots = GetOpenInventorySlot();
	
	// Don't reward player if there is no open inventory slot
	if (!is_undefined(open_slots)) {
		// Check if quest is completed
		for (var quest = 0; quest < array_length(quests); quest++) {
			if (quests[quest].completed) {	
				// Check if any items have not been rewarded yet
				for (var reward = 0; reward < array_length(quests[quest].rewards.items); reward++) {
					if (!quests[quest].rewards.items[reward].rewarded) {
						// Update global inventory array with item slots
						UpdateInventoryArray();
						
						// Define item being added
						var item = global.items[quests[quest].rewards.items[reward].item];
						
						// Return an open slot in the inventory
						var open_slot = GetOpenInventorySlot();
						
						// Don't reward player if there is no open inventory slot
						if (is_undefined(open_slot)) {
							continue;
						}
						
						// Add item to inventory
						item.slot = open_slot;
						item.quantity = quests[quest].rewards.items[reward].quantity;
						ds_list_add(global.inventory, item);
						
						// Set rewarded to true for the quest item
						quests[quest].rewards.items[reward].rewarded = true;
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
function hasUnclaimedRewards(quests) {
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
						//show_message(quests[quest].rewards.items[item]);
						num_of_rewards++;
					}
				}
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
	global.quests[$ data[1]].completed = true;
	
	var rewards;
	rewards = global.quests[$ data[1]].rewards;
	
	// Iterate over each key in the quest_list struct
	var keys = variable_struct_get_names(rewards);
	
	for (var i = 0; i < array_length(keys); i++) {
	    // Get the current key
	    var current_key = keys[i];
    
	    // Access the struct at the current key
	    var current_reward = rewards[$ current_key];
		
		// Reward the player for quest completion
		switch (current_key) {
			case "currency":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						updateCurrency(rewards[$ current_key].quantity);
						rewards[$ current_key].rewarded = true;
					}
				}
			break;
			case "inventory":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						unlockInventorySlots(rewards[$ current_key].quantity);
						rewards[$ current_key].rewarded = true;
					}
				}
			break;
			case "reputation":
				if (rewards[$ current_key] != noone) {
					if (!rewards[$ current_key].rewarded) {
						updateReputation(rewards[$ current_key].quantity);
						rewards[$ current_key].rewarded = true;	
					}
				}
			break;
			case "items":
				if (rewards[$ current_key] != noone) {
					for (var items = 0; items < array_length(rewards[$ current_key]); items++) {
						if (!rewards[$ current_key][items].rewarded) {
							// Update global inventory array with item slots
							UpdateInventoryArray();
						
							// Define item being added
							var item = global.items[rewards[$ current_key][items].item];
						
							// Return an open slot in the inventory
							var open_slot = GetOpenInventorySlot();
						
							// Don't reward player if there is no open inventory slot
							if (is_undefined(open_slot)) {
								continue;
							}
						
							// Add item to inventory
							item.slot = open_slot;
							item.quantity = rewards[$ current_key][items].quantity;
							ds_list_add(global.inventory, item);
						
							// Set rewarded to true for the quest item
							rewards[$ current_key][items].rewarded = true;
						}
					}
				}
			break;
		}
	}
	
	return;
};
