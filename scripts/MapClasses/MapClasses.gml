function mapClass(map_id, map_name) {

	var new_map = {
		id: map_id,
	    name: map_name,
	    description: "",
	    //completed: false,
		//started: false,
		//next_map: noone, // Next map to be unlocked after completion new limHouse(),
		//nextMap: function (next_map) {
		//	// Create a new instance of a map
		
		//	// Store the new map data within a global array
		
		//	// Map array will contain their instances
		
		//	// Every instance will be tracked whenever in the room (CRUD)
		//	// - Create, read, update, delete controller for instances in a map
		//	// - Function to update another maps instances from a different room
		//},
		//instances: [
		//	//{
		//	//	instance: data,
		//	//	coords: [x, y],
		//	//	persistant: true, // Does the instance stay persistance upon re-entering the map
		//	//}
		//],
		//starting_requirements: [], // Requirements to unlock the map
		//completing_requirements: [ // Requirements to complete the map
		//	// Quests, currency, reputation, items, dialog, time
		//],
		//rules: [], // Can certain players like Daniel or Luna be able to enter this map
	}
	
	return new_map;
}

//function save_data_get_key(){
//	return room_get_name(room) + object_get_name(object_index) + string(x) + string(y),
//}