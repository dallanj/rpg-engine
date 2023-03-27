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
		
		if (map.id == key) {
			result = map;	
			break;
		}
	}
	
	return result;
};

/**
* Destroy all child objects of a given list of parents within a room
*
* @param array (parents)
*
* @return void
*/
function destroyChildInstances(parents) {
	with (all) {
		for (var i = 0; i < array_length(parents); i++) {
			if (object_is_ancestor(object_index, parents[i])) {
			    instance_destroy(object_index);
			}
		}
	}
};

/**
* Create instances based on given map data
*
* @param array (data)
* @param string (map_layer)
*
* @return void
*/
function createMapInstances(data, map_layer = "Instances") {
	for (var i = 0; i < array_length(data); i ++) {
		var instance = data[i].instance;
		var coords = data[i].coords;
		
		// Create instance of object using their saved coordinates
		var new_instance = instance_create_layer(coords[0], coords[1], map_layer, instance.object);
		
		// Set the instance data based on map layer
		switch (map_layer) {
			case "NPC":
				// TODO: save NPC and dialog data
			break;
			default: // Instances (items)
				if (instance.stackable) {
					// Set the quantity of the new instance
					with (new_instance) {
						item.quantity = instance.quantity;
					}
				}
		};
	}
};

/**
* Saves all child instance data of a specific parent within a room
*
* @return void
*/
function saveMapInstances() {
	// Reinitialize the array of instances
	global.maps[room].instances = [];
	
	// Iterate through all instances within the room
	with (all) {
	    // If instance is a child of a parent object
		// TODO: save NPC and dialog data
	    if (object_is_ancestor(object_index, obj_item_controller)) {
			var obj = {
				instance: id.item,
				coords: [x, y],
			};
			array_push(global.maps[room].instances, obj);
	    }
	}
};

