/**
* Completes a quest and rewards the player
*
* @param key (enum)
*
* @return mixed
*/
function getMapById(key) {
	var maps = global.maps;
	var result = false;
	
	for (var i = 0; i < array_length(maps); i++) {
		var map = maps[i];
		
		if (maps[i].id == key) {
			result = maps[i];	
			break;
		}
	}
	
	return result;
};