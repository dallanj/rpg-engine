function Player() constructor {
	// Player states and controls
	states = ["idle", "walking"];
	controls = ["W", "A", "S", "D"];
	Speed = 3;
	Fps = 0.3;
	frames = {
		W: [12, 13, 14, 15],
		A: [4, 5, 6, 7],
		S: [0, 1, 2, 3],
		D: [8, 9, 10, 11],
	};
	
	// Current state of player
	state = {
		activity: "idle",
		sprites: frames.S,
		Speed: Speed,
		Fps: 0,
		keys: [] // Current keys being pressed
	};
	
	// Return array of sprite indexes
	static getFrames = function(key) {
		
		// Get array of struct keys
		var keys = variable_struct_get_names(frames);
		
		// Find the struct value using key
		for (var i = 0; i < array_length(keys); i++;) {
		    if (key == keys[i]) {
				show_debug_message("getFrame " + string(key));
				 return variable_struct_get(frames, key);	
			}
		}
		
		return false;
	};
	
	// Find key within controls array
	static findKey = function(key) {
		show_debug_message(string(typeof(key)) + "you  " + string(key));
		var result = false;
		
		// Return if key is found in controls
		for (var i = 0; i < array_length(controls); i++) {
			if (
				(typeof(key) == "number" && key == ord(controls[i]))
				|| key == controls[i]
			) {
				result = controls[i];
				break;
			}
		}
		
		return result;
	};
	
	// Remove inactive keys from state and push a new key if not in active keys
	static updateKeys = function(key = false) {
		
		// Find if key exists in the controls
		if (key != false) {
			key = findKey(key);
			
			// Return if key is not found
			if key == false return;
			
		}
		
		var exists = false;
		
		// Check each of the active keys if they are being pressed
		if (array_length(state.keys)) {
			
			// Remove inactive keys
			for (var i = 0; i < array_length(state.keys); i++) {
				
				if (key != false && state.keys[i] == key) {
					exists = true;
				}
				
				// If the key being checked has been released
				if keyboard(state.keys[i], true) {
					// Delete key from state
					array_delete(state.keys, i, 1);
					i--;
				}
			}
		}
		
		// Push current key to keys collection if it does not exist
		if (key != false && !exists) {
			array_push(state.keys, key);
		}
		
		// Update the players state
		updatePlayer();
		
		return;
	};
	
	/// @function   step()
    static updatePlayer = function() {
		
		// Update player state to idle if no keys are active
		if (!array_length(state.keys)) {
			state.activity = "idle";
			state.Fps = 0;
			return;
		}
		
		// Find if key exists in the controls
		var key = findKey(state.keys[0]);
		
		// Return if key is not found
		if key == false return;
		
		// Update player state to walking
		state.activity = "walking";
		state.Fps = Fps;
		var indexes = getFrames(key);
		
		if (!is_undefined(indexes)) {
			state.sprites = indexes;
		};
		
		return;
    };
	
	/// @function   step()
    static keyboard = function(key, released = false) {
		var active;
		
		// Is key has been released
		if (released) {
			active = keyboard_check_released(ord(key));
		} else {
			// If key is actively being used
			active = keyboard_check(ord(key));
		}
		
		return active;
    };
	
	/// @function   step()
    static walking = function(key) {
		var result = false;
		
		// Return false if player state is not walking
		if (state.activity != "walking") return updatePlayer();
		
		// Check if most active key in state the same as the key being checked
		if (state.keys[0] == key) {
			result = true;
		}
		
		return result;
    };
}
