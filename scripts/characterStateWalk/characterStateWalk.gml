/**
* Character controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function characterStateWalk(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
		
		// NOTES
		
		// PLAYER STRUCT SHOULD ONLY CONTAIN SPRITE DATA, CONTROLS
			// Update active keys state
			self.player.updateKeys(keyboard_lastkey);
			// Remove image speed and reset image index to first index in the state
			if (image_speed != self.player.state.Fps) {
				image_speed = self.player.state.Fps;
				image_index = self.player.state.sprites[0];
			}
		break;
		case StateMemoryEvent.Step:
			// Left movement
			if self.player.keyboard("A") {
				changeImageIndex("A");
	
				if (!place_meeting(x - self.player.state.Speed, y, obj_wall)
					&& !place_meeting(x - self.player.state.Speed, y, obj_boundry_x)
					&& !place_meeting(x - self.player.state.Speed, y, obj_boundry_y)
				) {
					x -= self.player.state.Speed;
				} else {
					// Move 1 pixel until player is next to wall
			        while (!place_meeting(x - 1, y, obj_wall)
						&& !place_meeting(x - 1, y, obj_boundry_x)
						&& !place_meeting(x - 1, y, obj_boundry_y)
					) {
			            x--;
			        }
				}
			}

			// Right movement
			if self.player.keyboard("D") {
				changeImageIndex("D");
	
				if (!place_meeting(x + self.player.state.Speed, y, obj_wall)
					&& !place_meeting(x + self.player.state.Speed, y, obj_boundry_x)
					&& !place_meeting(x + self.player.state.Speed, y, obj_boundry_y)
				) {
					x += self.player.state.Speed;
				} else {
					// Move 1 pixel until player is next to wall
			        while (!place_meeting(x + 1, y, obj_wall)
						&& !place_meeting(x + 1, y, obj_boundry_x)
						&& !place_meeting(x + 1, y, obj_boundry_y)
					) {
			            x++;
			        }
				}
			}

			// Up movement
			if self.player.keyboard("W") {
				changeImageIndex("W");
	
				if (!place_meeting(x, y - self.player.state.Speed, obj_wall)
					&& !place_meeting(x, y - self.player.state.Speed, obj_boundry_x)
					&& !place_meeting(x, y - self.player.state.Speed, obj_boundry_y)
				) {
					y -= self.player.state.Speed;
				} else {
					// Move 1 pixel until player is next to wall
			        while (!place_meeting(x, y - 1, obj_wall)
			            && !place_meeting(x, y - 1, obj_boundry_x)
						&& !place_meeting(x, y - 1, obj_boundry_y)
					) {
						y --;
			        }
				}
			}

			// Down movement
			if self.player.keyboard("S") {
				changeImageIndex("S");
	
				if (!place_meeting(x, y + self.player.state.Speed, obj_wall)
					&& !place_meeting(x, y + self.player.state.Speed, obj_boundry_x)
					&& !place_meeting(x, y + self.player.state.Speed, obj_boundry_y)
				) {
					y += self.player.state.Speed;
				} else {
					// Move 1 pixel until player is next to wall
			        while (!place_meeting(x, y + 1, obj_wall)
						&& !place_meeting(x, y + 1, obj_boundry_x)
						&& !place_meeting(x, y + 1, obj_boundry_y)) {
						y ++;
					}
				}
			}

			// Plays specified list of image indexes
			function changeImageIndex(key) {
	
				// Play sprite animations if the key is currently active and walking is allowed
				if (self.player.walking(key)) {
					// Loop through sprite image indexes in players state
					if (image_index > self.player.state.sprites[array_length(self.player.state.sprites) - 1] || image_index < self.player.state.sprites[0]) {
						image_index = self.player.state.sprites[0];
				    }
				}
			}

		break;
		case StateMemoryEvent.DrawGui:
			draw_set_color(c_white);
			draw_text(20,20,string_hash_to_newline("State: "+string(stateLayer.activeState)
              +"#previous: "+string(stateLayer.previousState))
         );
		break;
		//default:
			//
	};
}