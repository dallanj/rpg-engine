/**
* Unlock dialog scripts
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

function updateCurrency(amount) {
	global.currency += amount;
};

function updateReputation(amount) {
	global.reputation += amount;
};

function updateInventory(item, add, quantity) {
	//show_message(string(item) + " item  " + string(add) + " " + string(quantity));
	AddItem(item, quantity, true);
};

function startQuest(data) {
	global.quests[$ data[1]].started = true;
};

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
};

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

function completeQuest(data) {
	global.quests[$ data[1]].completed = true;
	
	//show_message(global.quests[$ data[1]].rewards);
	var rewards;
	rewards = global.quests[$ data[1]].rewards;
	// Iterate over each key in the quest_list struct
	var keys = variable_struct_get_names(rewards);
	//show_message(keys);
	//show_message(string(quest_keys));
	for (var i = 0; i < array_length(keys); i++) {
		//show_message(global.quests.quest_keys[i]);
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
					//show_message("items: " +string(rewards[$ current_key]));
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
