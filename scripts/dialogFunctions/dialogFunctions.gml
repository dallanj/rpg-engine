/**
* Unlock dialog scripts
*
* @param data (array)
*
* @return void
*/
function unlockDialog(data) {
	if (data != noone) {
		//for (j = 0; j < array_length(data); j++) {	
		//	with(data[1]) {
		//		obj_data.dialog_current = data[other.j][1];
		//	}
		//}
		with(data[1]) {
			obj_data.dialog_current = data[2];
			
		}
		//show_message(data);
	}
	
	return;
};

function updateCurrency(amount) {
	global.currency += amount;
};

function updateInventory(item, add, quantity) {
	//show_message(string(item) + " item  " + string(add) + " " + string(quantity));
	AddItem(item, quantity, true);
};

function startQuest(data) {
	global.quests[$ data[1]].started = true;
};

function completeQuest(data) {
	global.quests[$ data[1]].completed = true;
};
