if (!getMapById(room)) {
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
} else {
	// Delete all items on room start
	destroyChildInstances([obj_item_controller]);
	
	// Spawn all items with their new coordinates and data saved in global maps array
	createMapInstances(global.maps[room].instances, "Instances");
}
