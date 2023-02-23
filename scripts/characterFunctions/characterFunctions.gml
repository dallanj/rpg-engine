/**
* Get character image index assigned to specific key
*
* @param _key (string)
* @param _frames (struct)
*
* @return mixed
*/
function characterGetFrames(_key, _frames) {
	// Get array of struct keys
	var _keys = variable_struct_get_names(_frames);
		
	// Find the struct value using key
	for (var i = 0; i < array_length(_keys); i++) {
		if (_key == _keys[i]) {
			return variable_struct_get(_frames, _key);	
		}
	}
	
	return false;
}

/**
* Check if a key is being pressed or released
*
* @param _key (string|int)
* @param _released (boolean)
*
* @return boolean
*/
function characterKeyboard(_key, _released = false) {
	var _active;
		
	// Is key has been released
	if (_released) {
		_active = keyboard_check_released(ord(_key));
	} else {
		// If key is actively being used
		_active = keyboard_check(ord(_key));
	}
		
	return _active;
}

/**
* Check if any of keys are actively being held
*
* @param _keys (array)
*
* @return boolean
*/
function characterCheckKeys(_keys) {
	var _active = false;
		
		
	for (var i = 0; i < array_length(_keys); i++) {
		_active = keyboard_check(ord(_keys[i]));
			
		if (_active) break;
	}
		
	return _active;
};

/**
* Change _sprites image index and image speed
*
* @param _sprites (array)
* @param index_speed (int)
*
* @return boolean
*/
function characterAnimation(_sprites, _index_speed) {
	if (
		(characterKeyboard("A") && characterKeyboard("D"))
		|| (characterKeyboard("W") && characterKeyboard("S"))
	) {
		// Change image speed to 0 if player is hold both _vertical or both horizontal controls
		image_speed = 0;
		image_index = _sprites[0];
	} else {
		image_speed = _index_speed;
		if (round(image_index) > _sprites[array_length(_sprites) - 1] || round(image_index) < _sprites[0]) {
			image_index = _sprites[0];
		}
	}
	
	return;
}

/**
* Create movement for character
*
* @param _pos (int)
* @param _spd (int)
* @param _object (int)
* @param _vertical (boolean)
*
* @return boolean
*/
function characterMovement(_pos, _spd, _object, _vertical = false) {
	var _position_free = true;
	
	if (_vertical) {
		if (
			!place_meeting(x, y + (_pos * (_spd * sign(_spd))), _object)
			//&& !place_meeting(x, y + (_pos * (_spd * sign(_spd))), obj_npc_controller)
		) {
			y += _spd;
		} else {
			// Move 1 pixel until player is next to wall
			while (
				!place_meeting(x, y + _pos, _object)
				//&& !place_meeting(x, y + _pos, obj_npc_controller)
			) {
				y += _pos;
			}
			_position_free = false;
		}
	} else {
		if (
			!place_meeting(x + (_pos * (_spd * sign(_spd))), y, _object)
			//&& !place_meeting(x + (_pos * (_spd * sign(_spd))), y, obj_npc_controller)
		) {
			x += _spd;
		} else {
			// Move 1 pixel until player is next to wall
			while (
				!place_meeting(x + _pos, y, _object)
				//&& !place_meeting(x + _pos, y, obj_npc_controller)
			) {
				x += _pos;
			}
			_position_free = false;
		}
	}
	
	return _position_free;
}

/**
* Remove inactive keys from state and push a new key to active keys
*
* @param keys (array)
* @param _active_keys (array)
* @param _frames (struct)
* @param _sprites (array)
*
* @return array
*/
function characterUpdateKeys(_keys, _active_keys, _frames, _sprites) {
	var _exists; // Key exists in active keys
		
	if (array_length(_keys)) {
		for (var i = 0; i < array_length(_keys); i++) {
			_exists = false;
				
			// Check each of the active keys if they are being pressed
			if (array_length(_active_keys)) {
			
				// Remove inactive keys
				for (var j = 0; j < array_length(_active_keys); j++) {
						
					if (_active_keys[j] == _keys[i]) {
						_exists = true;
					}
				
					// If the key being checked has been released
					if characterKeyboard(_active_keys[j], true) {
						// Delete key from state
						array_delete(_active_keys, j, 1);
						j--;
					}
				}
			}
				
			// Push current key to keys collection if it does not exist
			if (!_exists && characterKeyboard(_keys[i])) {
				array_push(_active_keys, _keys[i]);
			}
		}
	}
		
	if (array_length(_active_keys)) {
		var _indexes;
			
		// Prioritize horizontal movement over vertical
		if (array_length(_active_keys) > 1) {
			if (_active_keys[0] == "W" || _active_keys[0] == "S") {
				switch (_active_keys[1]) {
					case "A":
					case "D":
						_indexes = characterGetFrames(_active_keys[1], _frames);
					break;
					default:
						_indexes = characterGetFrames(_active_keys[0], _frames);
				}
			} else {
				_indexes = characterGetFrames(_active_keys[0], _frames);
			}
		} else {
			_indexes = characterGetFrames(_active_keys[0], _frames);
		}
			
		if (!is_undefined(_indexes)) {
			_sprites = _indexes;
		}
	}
		
	return _sprites;
};

/**
* Draw character state for testing only
*
* @param _state (struct)
* @param _stateLayer (struct)
*
* @return void
*/
function characterDrawGui(_state, _stateLayer) {
	draw_set_color(c_white);
	draw_text(20,20,string_hash_to_newline("State: "+string(_stateLayer.activeState.name)
        +"#previous: "+string(_stateLayer.previousState.name)
		+"#keys: "+string(_state.keys)
		+"#sprites: "+string(_state.sprites))
    );
	
	return;
};
