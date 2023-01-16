/**
* Get character image index assigned to specific key
*
* @param key (string)
* @param frames (struct)
*
* @return mixed
*/
function characterGetFrames(key, frames) {
	// Get array of struct keys
	var keys = variable_struct_get_names(frames);
		
	// Find the struct value using key
	for (var i = 0; i < array_length(keys); i++) {
		if (key == keys[i]) {
			return variable_struct_get(frames, key);	
		}
	}
	
	return false;
}

/**
* Check if a key is being pressed or released
*
* @param key (string|int)
* @param released (boolean)
*
* @return boolean
*/
function characterKeyboard(key, released = false) {
	var active;
		
	// Is key has been released
	if (released) {
		active = keyboard_check_released(ord(key));
	} else {
		// If key is actively being used
		active = keyboard_check(ord(key));
	}
		
	return active;
}

/**
* Check if any of keys are actively being held
*
* @param keys (array)
*
* @return boolean
*/
function characterCheckKeys(keys) {
	var active = false;
		
		
	for (var i = 0; i < array_length(keys); i++) {
		active = keyboard_check(ord(keys[i]));
			
		if (active) break;
	}
		
	return active;
};

/**
* Change sprites image index and image speed
*
* @param sprites (array)
* @param index_speed (int)
*
* @return boolean
*/
function characterAnimation(sprites, index_speed) {
	if (
		(characterKeyboard("A") && characterKeyboard("D"))
		|| (characterKeyboard("W") && characterKeyboard("S"))
	) {
		// Change image speed to 0 if player is hold both vertical or both horizontal controls
		image_speed = 0;
		image_index = sprites[0];
	} else {
		image_speed = index_speed;
		if (image_index > sprites[array_length(sprites) - 1] || image_index < sprites[0]) {
			image_index = sprites[0];
		}
	}
	
	return;
}

/**
* Create movement for character
*
* @param pos (int)
* @param spd (int)
* @param object (int)
* @param vertical (boolean)
*
* @return boolean
*/
function characterMovement(pos, spd, object, vertical = false) {
	var position_free = true;
	
	if (vertical) {
		if (!place_meeting(x, y + (pos * (spd * sign(spd))), object)) {
			y += spd;
		} else {
			// Move 1 pixel until player is next to wall
			while (!place_meeting(x, y + pos, object)) {
				y += pos;
			}
			position_free = false;
		}
	} else {
		if (!place_meeting(x + (pos * (spd * sign(spd))), y, object)) {
			x += spd;
		} else {
			// Move 1 pixel until player is next to wall
			while (!place_meeting(x + pos, y, object)) {
				x += pos;
			}
			position_free = false;
		}
	}
	
	return position_free;
}

/**
* Remove inactive keys from state and push a new key to active keys
*
* @param keys (array)
* @param active_keys (array)
* @param frames (struct)
* @param sprites (array)
*
* @return array
*/
function characterUpdateKeys(keys, active_keys, frames, sprites) {
	var exists; // Key exists in active keys
		
	if (array_length(keys)) {
		for (var i = 0; i < array_length(keys); i++) {
			exists = false;
				
			// Check each of the active keys if they are being pressed
			if (array_length(active_keys)) {
			
				// Remove inactive keys
				for (var j = 0; j < array_length(active_keys); j++) {
						
					if (active_keys[j] == keys[i]) {
						exists = true;
					}
				
					// If the key being checked has been released
					if characterKeyboard(active_keys[j], true) {
						// Delete key from state
						array_delete(active_keys, j, 1);
						j--;
					}
				}
			}
				
			// Push current key to keys collection if it does not exist
			if (!exists && characterKeyboard(keys[i])) {
				array_push(active_keys, keys[i]);
			}
		}
	}
		
	if (array_length(active_keys)) {
		var indexes;
			
		// Prioritize horizontal movement over vertical
		if (array_length(active_keys) > 1) {
			if (active_keys[0] == "W" || active_keys[0] == "S") {
				switch (active_keys[1]) {
					case "A":
					case "D":
						indexes = characterGetFrames(active_keys[1], frames);
					break;
					default:
						indexes = characterGetFrames(active_keys[0], frames);
				}
			} else {
				indexes = characterGetFrames(active_keys[0], frames);
			}
		} else {
			indexes = characterGetFrames(active_keys[0], frames);
		}
			
		if (!is_undefined(indexes)) {
			sprites = indexes;
		}
	}
		
	return sprites;
};

/**
* Draw character state for testing only
*
* @param state (struct)
* @param stateLayer (struct)
*
* @return void
*/
function characterDrawGui(state, stateLayer) {
	draw_set_color(c_white);
	draw_text(20,20,string_hash_to_newline("State: "+string(stateLayer.activeState.name)
        +"#previous: "+string(stateLayer.previousState.name)
		+"#keys: "+string(state.keys)
		+"#sprites: "+string(state.sprites)
		+"#player_speed: "+string(state.Speed))
    );
	
	return;
};
