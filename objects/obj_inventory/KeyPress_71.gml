var item = global.inventory_array[slot_pos];

if (item) {
	// Get players current direction
	with (obj_player) {
		
		// Players current position
		var player_x = x;
		var player_y = y;
		var player_width = sprite_width;
		var player_height = sprite_height;
		
		// Drop item based on the direction player is facing
		switch (image_index) {
			case 0: // W
				DropItem(player_x, player_y - player_height, "Instances", item);
			break;

		    case 1: // D
		        DropItem(player_x + player_width, player_y, "Instances", item);
		    break;
			
			case 2: // S
		        DropItem(player_x, player_y + player_height, "Instances", item);
		    break;
			
		    default: // A
		        DropItem(player_x - player_width, player_y, "Instances", item);
		}
	}
}