/**
* Unlock dialog scripts
*
* @param data (array)
*
* @return void
*/
function unlockDialog(data) {
	if (data != noone) {
		for (i = 0; i < array_length(data); i++) {	
			with(data[i][0]) {
				obj_data.dialog_current = data[other.i][1];
			}
		}
	}
};

function completeQuest() {
	show_debug_message("completeQuest");	
};
