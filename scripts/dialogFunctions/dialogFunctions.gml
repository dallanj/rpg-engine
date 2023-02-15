/**
* Unlock dialog scripts
*
* @param data (array)
*
* @return void
*/
function unlockDialog(data) {
	if (data != noone) {
		for (k = 0; k < array_length(data); k++) {	
			with(data[k][0]) {
				obj_data.dialog_current = data[other.k][1];
			}
		}
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
