/** Alert messages will drawn above the player in FIFO
* Alert message types:
* - Started quest
* - Completed quest
* - Currency gained
* - Reputation gained
* - Items gained
* - Unclaimed rewards
* - Inventory slots unlocked
* - Dialog unlocks
**/


/**
* Create and store a new alert
*
* @param type (string)
* @param data (mixed)
*
* @return void
*/
function storeAlert(type, data) {
	
	var title, new_instance;
	
	// Default size and placementections for alerts
	var size = "small";
	var placement = "left-bottom";
	var item = noone;
	
	switch (type) {
		case Action.StartQuest:
			title = "Quest Started: " + string(data.name);
			size = "medium";
			placement = "center-top";
		break;
		case Action.CompleteQuest:
			title = "Quest Completed: " + string(data.name);
			size = "medium";
			placement = "center-top";
		break;
		case Action.UnlockDialog:
			title = string(data.name) + " has some info for you!";
			size = "medium";
			placement = "center-top";
			return;
		break;
		case Action.UpdateCurrency:
			title = "Earned " + string(data) + " currency!";
		break;
		case Action.UnlockSlots:
			title = "Unlocked " + string(data) + " slots!";
		break;
		case Action.UpdateReputation:
			title = "Earned " + string(data) + " reputation!";
		break;
		case Action.UnclaimedRewards:
			title = string(data.name) + " has rewards for you!";
			size = "medium";
			placement = "center-top";
		break;
		case Action.UpdateInventory:
			item = data;
			
			if (data.stackable) {
				var result = updateAlert(Action.UpdateInventory, data);
				
				// If the alert exists and updated then do not create a new alert
				if (result) return;
				
				title = string(data.name) + " x "+string(data.quantity);
			} else {
				title = data.name;
			}
			
		break;
	}
	
	// Create a new instance of the alert object
	new_instance = instance_create_layer(obj_player.x, obj_player.y, "alerts", obj_alert);
	
	with (new_instance) {
		alert.title = title;
		alert.type = type;
		alert.size = size;
		alert.placement = placement;
		alert.item = item;
		alert.quantity = item != noone ? item.quantity : noone;
	}
	
	// Join new alert with all active alerts
	if (placement == "center-top") {
		ds_list_add(global.alerts_top,new_instance.alert);
	} else {
		ds_list_add(global.alerts_bottom,new_instance.alert);
	}
	
	return;
};

/**
* Update existing alert
*
* @param type (string)
* @param data (mixed)
*
* @return void
*/
function updateAlert(type, data) {
	var updated = false;
	var alert;
	
	// Find the alert if it exists and update the quantity
	for (var i = 0; i < ds_list_size(global.alerts_bottom); i ++) {
		alert = ds_list_find_value(global.alerts_bottom, i);
		
		// Update the alert message with additional item quantity
		if (alert.item != noone && alert.item.name == data.name) {
			var new_quantity = alert.quantity + data.quantity;
			
			alert.title = string(data.name) + " x "+string(new_quantity);
			alert.quantity = new_quantity;
			updated = true;
			break;
		}
	}
	
	return updated;
};

/**
* Removes alert after showing the player
*
* @param type (string)
* @param data (mixed)
*
* @return void
*/
function destroyAlert(alert) {
	var position;
	
	// Get index position of alert within alerts list
	var alerts = alert.placement == "center-top" ? global.alerts_top : global.alerts_bottom;
		
	position = ds_list_find_index(alerts, alert);
	
	// Delete alert if found in the list of alerts
	if (position >= 0) {
		ds_list_delete(alerts, position);
	}
	
	// Destroy alert instance
	if (instance_exists(self)) {
		instance_destroy(self);
	}
	
	return;
};

/**
* Clear all alerts
*
* @return void
*/
function clearAlerts() {
	
	// Clear data list of active alerts
	if (global.alerts_top) {
		ds_list_clear(global.alerts_top);
	}
	
	if (global.alerts_bottom) {
		ds_list_clear(global.alerts_bottom);
	}
	
	// Delete all alert instances
	if (layer_exists("alerts")) {
		layer_destroy_instances("alerts");
	}
	
	return;
};