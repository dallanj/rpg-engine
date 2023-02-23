var item = global.inventory_array[slot_pos];

if (item) {
	// Get players current direction
	with (obj_player) {
		var is_walking = this.activeState.id == State.walk;
		
		// Players current position
		var player_x = x;
		var player_y = y;
		var player_width = sprite_width;
		var player_height = sprite_height;
		var layer_name = "Instances";
		
		// Item drop position according to player's state and current position + or - the w or h of the player sprite 
		var item_position;
		
		// Drop item based on the direction player is facing
		switch (floor(image_index)) {
			case 0: case 1: case 2: case 3:
				// Player facing south
				item_position = is_walking ? player_y - player_height / 2 : player_y + player_height;
				
				dropItem(player_x, item_position, layer_name, item);
			break;
		    case 4: case 5: case 6: case 7:
				// Player facing west
				item_position = is_walking ? player_x + player_width / 2 : player_x - player_width;
		        
				dropItem(item_position, player_y, layer_name, item);
		    break;	
			case 8: case 9: case 10: case 11:
				// Player facing east
				item_position = is_walking ? player_x - player_width / 2 : player_x + player_width;
		        dropItem(item_position, player_y, layer_name, item);
		    break;
		    default:
				// Player facing north
				item_position = is_walking ? player_y + player_height / 2 : player_y - player_height;
				dropItem(player_x, item_position, layer_name, item);
				
		}
	}
}