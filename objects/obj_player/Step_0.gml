/// @description Player movements
this.event(StateMemoryEvent.Step);

// Left movement
//if player.keyboard("A") {
//	changeImageIndex("A");
	
//	if (!place_meeting(x - player.state.Speed, y, obj_wall)
//		&& !place_meeting(x - player.state.Speed, y, obj_boundry_x)
//		&& !place_meeting(x - player.state.Speed, y, obj_boundry_y)
//	) {
//		x -= player.state.Speed;
//	} else {
//		// Move 1 pixel until player is next to wall
//        while (!place_meeting(x - 1, y, obj_wall)
//			&& !place_meeting(x - 1, y, obj_boundry_x)
//			&& !place_meeting(x - 1, y, obj_boundry_y)
//		) {
//            x--;
//        }
//	}
//}

//// Right movement
//if player.keyboard("D") {
//	changeImageIndex("D");
	
//	if (!place_meeting(x + player.state.Speed, y, obj_wall)
//		&& !place_meeting(x + player.state.Speed, y, obj_boundry_x)
//		&& !place_meeting(x + player.state.Speed, y, obj_boundry_y)
//	) {
//		x += player.state.Speed;
//	} else {
//		// Move 1 pixel until player is next to wall
//        while (!place_meeting(x + 1, y, obj_wall)
//			&& !place_meeting(x + 1, y, obj_boundry_x)
//			&& !place_meeting(x + 1, y, obj_boundry_y)
//		) {
//            x++;
//        }
//	}
//}

//// Up movement
//if player.keyboard("W") {
//	changeImageIndex("W");
	
//	if (!place_meeting(x, y - player.state.Speed, obj_wall)
//		&& !place_meeting(x, y - player.state.Speed, obj_boundry_x)
//		&& !place_meeting(x, y - player.state.Speed, obj_boundry_y)
//	) {
//		y -= player.state.Speed;
//	} else {
//		// Move 1 pixel until player is next to wall
//        while (!place_meeting(x, y - 1, obj_wall)
//            && !place_meeting(x, y - 1, obj_boundry_x)
//			&& !place_meeting(x, y - 1, obj_boundry_y)
//		) {
//			y --;
//        }
//	}
//}

//// Down movement
//if player.keyboard("S") {
//	changeImageIndex("S");
	
//	if (!place_meeting(x, y + player.state.Speed, obj_wall)
//		&& !place_meeting(x, y + player.state.Speed, obj_boundry_x)
//		&& !place_meeting(x, y + player.state.Speed, obj_boundry_y)
//	) {
//		y += player.state.Speed;
//	} else {
//		// Move 1 pixel until player is next to wall
//        while (!place_meeting(x, y + 1, obj_wall)
//			&& !place_meeting(x, y + 1, obj_boundry_x)
//			&& !place_meeting(x, y + 1, obj_boundry_y)) {
//			y ++;
//		}
//	}
//}

//// Plays specified list of image indexes
//function changeImageIndex(key) {
	
//	// Play sprite animations if the key is currently active and walking is allowed
//	if (player.walking(key)) {
//		// Loop through sprite image indexes in players state
//		if (image_index > player.state.sprites[array_length(player.state.sprites) - 1] || image_index < player.state.sprites[0]) {
//			image_index = player.state.sprites[0];
//	    }
//	}
//}
