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
function StoreAlert(type, data) {
	
	var title, new_instance;
	
	// Default size and placementections for alerts
	var size = "small";
	var placement = "left-bottom";
	
	switch (type) {
		case "startQuest":
			title = "Quest Started: " + string(global.quests[$ data[1]].name);
			size = "medium";
			placement = "center-top";
		break;
		case "completeQuest":
			title = "Quest Completed: " + string(global.quests[$ data[1]].name);
			size = "medium";
			placement = "center-top";
		break;
		case "unlockDialog":
			title = string(data.obj_data.name) + " has some info for you!";
			size = "medium";
			placement = "center-top";
		break;
		case "currency":
			title = "Earned " + string(data) + " currency!";
		break;
		case "inventory":
			title = "Unlocked " + string(data) + " slots!";
		break;
		case "reputation":
			title = "Earned " + string(data) + " reputation!";
		break;
		case "unclaimedRewards":
			title = string(data.obj_data.name) + " has rewards for you!";
			size = "medium";
			placement = "center-top";
		break;
		case "items":
			if (variable_struct_exists(data, "item")) {
				if (data.item.stackable) {
					title = "Earned "+string(data.quantity)+" x "+string(data.item.name)+"s";	
				} else {
					title = "Earned "+string(data.item.name);
				}
			} else {
				if (data.stackable) {
					title = "Earned "+string(data.quantity)+" x "+string(data.name)+"s";	
				} else {
					title = "Earned "+string(data.name);
				}	
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
* Removes alert after showing the player
*
* @param type (string)
* @param data (mixed)
*
* @return void
*/
function DestroyAlert(alert) {
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
function ClearAlerts() {
	
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