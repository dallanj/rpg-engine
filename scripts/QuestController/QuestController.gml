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
							StoreAlert("currency", rewards[$ current_key].quantity);
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
							StoreAlert("inventory", rewarded);
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
							StoreAlert("reputation", rewards[$ current_key].quantity);
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
								StoreAlert("items", rewards[$ current_key][items]);
							}
						}
					}
				}
			break;
		}
	}
	
	return;
};