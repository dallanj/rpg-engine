//show_message("ROOM START :" + string(room_get_name(room)));

//show_message("ROOM START :" + string(room));


if (!getMapById(room)) {
	//show_message("NOT EXIST");
	var new_map = mapClass(room, room_get_name(room));
	var description;
	
	switch (room) {
		case Map.DanielsRoom:
			description = "Daniels bedroom";
		break;
		case Map.LimHouse:
			description = "The Lim's family house";
		break;
	}
	
	// Add the maps properties to the map structure
	new_map.description = description;
	
	// Store map within players unlocked maps memory
	global.maps[room] = new_map;
	//show_message(global.maps);
} else {

}
