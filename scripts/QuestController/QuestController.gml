/**
* Check if the quest is in between minimum start date and or maximum end date
*
* @param data (object)
*
* @return boolean
*/
function compareDates(data) {
	var result = false;
	var start_date = data.start_date;
	var end_date = data.end_date;
	
	// Compare day, hours, or minutes. Returns boolean or boolean/noone
	var compare = function(value, compared_to, starting = true, boolean = false) {
		var result;
			
		if (value < compared_to) {
			result = starting ? true : false;
		} else if (value > compared_to) {
			result = starting ? false : true;
		} else {
			// Return boolean or noone
			result = boolean ? true : noone;
		}
			
		return result;
	};
	
	// MIN Starting date compared to today
	if (start_date != noone) {
		// Compare the starting day with today
		result = compare(start_date.day, global.day);
		
		// Compare the hours if starting day is today
		if (result == noone) {
			result = compare(start_date.hours, global.hours);
		}
		
		// Compare the minutes if the starting hour is todays hour
		if (result == noone) {
			result = compare(start_date.minutes, global.minutes, true);
		}
	}
	
	// MAX Ending date compared to today
	if (end_date != noone) {
		// Compare the starting day with today
		result = compare(end_date.day, global.day, false);
		
		// Compare the hours if starting day is today
		if (result == noone) {
			result = compare(end_date.hours, global.hours, false);
		}
		
		// Compare the minutes if the starting hour is todays hour
		if (result == noone) {
			result = compare(end_date.minutes, global.minutes, false, true);
		}
	}
	
	return result;
}

/**
* Check if the quest has been started or completed
*
* @param data (object)
*
* @return boolean
*/
function questStatus(data) {
	var result = false;
	
	// Get the quest data
	var quest = getQuestById(data.quest);
	
	if (!quest) {
		return result;
	}
	
	// Check the status of the quest
	if (data.started != noone) {
		result = quest.started ? true : false;
	}
	
	if (data.completed != noone) {
		result = quest.completed ? true : false;
	}
	
	return result;
}

/**
* Begin a quest
*
* @param quest (string)
*
* @return boolean
*/
function startQuest(quest) {
	// Return if player has already started the quest
	if (quest.started) {
		return false;
	}
	
	// Have all starting requirement conditions been met
	var conditions_met = true;
	
	// List of the quest's rewards
	var requirements = quest.starting_requirements;
	
	// Iterate over each requirement in the list
	for (var i = 0; i < array_length(requirements); i++) {
		var data = requirements[i];
		
		if (!data.valid) {
			// Check if the player passed the requirement
			var validated = false;
			
			// Type of requirement
			var action = data.action;
			
			// Value of the requirement
			var value = data.value;
			
			switch (action) {
				case QuestController.QuestStatus:
					// Has currency been awarded to the player
					validated = questStatus(value);
				break;
				case QuestController.CompareDates:
					// Has currency been awarded to the player
					validated = compareDates(value);
				break;
			}
			
			// Set the starting requirement to validated
			if (validated) {
				data.valid = true;
			} else {
				// If atleast one condition hasn't been met then the player cant start the quest yet
				conditions_met = false;	
			}	
		}
	}
	
	// Start the quest if all starting requirements are met
	if (conditions_met) {
		quest.started = true;
		array_push(global.quests, quest);
		return true;
	} else {
		return false;
	}
};

/**
* Return all quests by a specific npc or item
*
* @param npc (int/object)
*
* @return array
*/
function getQuestsByNpc(npc) {
	var quests = global.quests;
	var results = [];
	
	// Find quests by NPC
	for (var i = 0; i < array_length(quests); i++) {
		var quest = quests[i];
		
		if (quest.npc == npc) {
			array_push(results, quest);	
		}
	}
	
	return results;
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
	for (var i = 0; i < array_length(items); i++) {
		var item = items[i];
		
		// Type of reward and it's action
		var action = item.action;
			
		// Value of reward
		var value = item.value;
		
		if (!item.rewarded) {
			// Has the item been awarded to the player
			var result = updateInventory(value);
							
			// Update unclaimed item as rewarded if the item has been awarded
			if (is_struct(result)) {
				
				// TODO: item quantities are wrong 7+7+2+2 = 18 but alerted x35 red shells
				
				// TESTED THAT x25+1 RED SHELLS DISPLAYED AS x50 red shells. FIX THIS BUG
				
				item.rewarded = true;
				storeAlert(action, result);
			} else if (result) {
				item.rewarded = true;
				storeAlert(action, value);
			}
			
		} else {
			// Remove claimed reward from npc's unclaimed rewards
			array_delete(items, i, 1);
		}
	}
	
	return items;
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
	for (var i = 0; i < array_length(quests); i++) {
		var quest = quests[i];
		
		if (quest.completed) {
			var rewards = quest.rewards;
			
			// Check if any items have not been rewarded yet
			for (var j = 0; j < array_length(rewards); j++) {
				var reward = rewards[j];
				
				// Type of reward and it's action
				var action = reward.action;
			
				// Value of reward
				var value = reward.value;
				
				if (!reward.rewarded && action == Action.UpdateInventory) {
					// Has the item been awarded to the player
					var result = updateInventory(value.item);
					
					// Update quest item as rewarded if the item has been awarded
					if (is_struct(result)) {
						
						// TODO: item quantities are wrong 7+7+2+2 = 18 but alerted x35 red shells
						reward.rewarded = true;
						storeAlert(action, result);
					} else if (result) {
						reward.rewarded = true;
						storeAlert(action, value.item);
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
	var open_slot = getOpenInventorySlot();
	
	// Don't reward player if there is no open inventory slot
	if (is_undefined(open_slot)) {
		// Check if quest is completed
		for (var i = 0; i < array_length(quests); i++) {
			var quest = quests[i];
			
			if (quest.completed) {
				// List of the quest's rewards
				var rewards = quest.rewards;
				
				// Check if any items have not been rewarded yet
				for (var j = 0; j < array_length(rewards); j++) {
					var reward = rewards[j];
					
					if (!reward.rewarded) {
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
	var item;
	
	// Number of unclaimed rewards
	var num_of_rewards = 0;
	
	// Find an open slot
	var open_slot = getOpenInventorySlot();
	
	// Don't reward player if there is no open inventory slot
	if (is_undefined(open_slot)) {
		
		// Check if quest is completed
		for (var i = 0; i < array_length(items); i++) {
			item = items[i];
			
			if (!item.rewarded) {
				num_of_rewards++;
			}
		}
	}
	
	return num_of_rewards;
};

/**
* Completes a quest and rewards the player
*
* @param key (enum)
*
* @return mixed
*/
function getQuestById(key) {
	var quests = global.quests;
	var result = false;
	
	for (var i = 0; i < array_length(quests); i++) {
		var quest = quests[i];
		
		if (quests[i].id == key) {
			result = quests[i];	
			break;
		}
	}
	
	return result;
};

/**
* Completes a quest and rewards the player
*
* @param data (array)
*
* @return void
*/
function completeQuest(key) {
	var result = false;
	
	var quest = getQuestById(key);
	
	if (!quest) {
		return result;
	}
	
	// Update quest to completed
	quest.completed = true;
	
	// List of the quest's rewards
	var rewards = quest.rewards;
	
	// Iterate over each reward in the list
	for (var i = 0; i < array_length(rewards); i++) {
		var reward = rewards[i];
		
		// Reward the player for quest completion
		if (!reward.rewarded) {
			var rewarded = false;
			
			// Type of reward and it's action
			var action = reward.action;
			
			// Value of reward
			var value = reward.value;
			
			// Data to be used for alert
			var alert_data = value;
			var alert_type = action;
		
			switch (action) {
				case Action.UpdateCurrency:
					// Has currency been awarded to the player
					rewarded = updateCurrency(value);
				break;
				case Action.UnlockSlots:
					// How many slots have been unlocked
					var amount = unlockInventorySlots(value);
						
					// Set the value of the reward to the number of slots unlocked
					if (amount > 0) {
						alert_data = amount;
						rewarded = true;
					}
				break;
				case Action.UpdateReputation:
					// Has reputation been awarded to the player
					rewarded = updateReputation(value);
				break;
				case Action.UpdateInventory:
					// Has reputation been awarded to the player
					result = updateInventory(value.item);
					
					if (!result) {
						alert_data = value.npc.obj_data;
						alert_type = Action.UnclaimedRewards;
						storeAlert(alert_type, alert_data);
					} else if (is_struct(result)) {
						alert_data = result;
						rewarded = true;
					} else  {
						alert_data = value.item;
						rewarded = true;
					}
				break;
			}
			
			// Update quest item as rewarded if the item has been awarded
			if (rewarded) {
				reward.rewarded = true;
				storeAlert(alert_type, alert_data);
			}	
		}
	}
	
	return quest;
};