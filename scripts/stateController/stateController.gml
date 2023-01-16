// Events for each state instance - some are optional
enum StateMemoryEvent {
	Step,
	Draw,
	DrawGui,
	Enter,
	Exit,
	SwitchState,
}

/**
* Generate a state machine specific to an instance
*
* @param activeState (function) || null
*
* @return state_layer (struct)
*/
function generateStateMemory(activeState = undefined) {
	
	// Generate a new state layer structure
	var stateLayer = new generateStateLayer();
	
	stateLayer.instanceOwner = self.id;
	
	// For basic state memories
	if (activeState != undefined) {
		stateLayer.addState(activeState);
	}
	
	return stateLayer;
}

/**
* Generic layer template for every state memory created
*
* @return state_layer (struct)
*/
function generateStateLayer() constructor {
	
	// Data
	stateOptions = {}; // State options for the layer
	
	originalState = undefined;
	previousState = undefined;
	nextState = undefined;
	isNewState = true;
	
	stateStack = ds_stack_create();
	
	stateSwitchLocked = false; // Lock the state from being able to switch
	stateShouldReset = false; // Should the state reset to original state
	
	activeState = undefined; // Current state of the instance
	stateHistory = ds_stack_create(); // Collection of states used per session
	stateTimer = 0; // Counter of steps taken within the active state
	
	/**
	* Create a new state for a layer
	*
	* @param stateId
	* @param stateFunction || null
	* @param stateName || null
	*
	* @return newState (struct)
	*/
	static addState = function(stateId, stateFunction = stateId, stateName = script_get_name(stateFunction)) {
		
		// Structure of new state
		var newState = {
			id: stateId,
			func: stateFunction,
			name: stateName,
		}
		
		// Add new state to stateOptions
		stateOptions[$ string(stateId)] = newState;
		
		// If original state is not set
		if (originalState == undefined) {
			originalState = newState;
			previousState = newState;
			nextState = newState;
		}
		
		return newState;
	}
	
	/**
	* Switch the active state
	*
	* @param stateId || null
	* @param locked || null (boolean)
	*
	* @return void
	*/
	static switchState = function(stateId = originalState.id, locked = false) {
		if (stateSwitchLocked) return;
		
		// Find the state we are switching to
		var state = stateOptions[$ string(stateId)];
		
		//If the state option is not found within the memory
		if (state == undefined) {
			
			// Find an existing function using stateId
			if (!script_exists(stateId)) {
				throw("State does not exist for this object");
				game_end();
			}
			
			// Create a new state to be added to memory for the instance
			state = addState(stateId, stateId);
		}
		
		// If the state is not active then set it to the next state and add the state to the stack
		if (activeState != state) {
			ds_stack_push(stateStack, state);
			nextState = state;
			isNewState = true;
		}
		
		// Lock the state from being switched
		if (locked != false) stateSwitchIsLocked = locked;
	}
	
	/**
	* Reset to the original switch
	*
	* @return void
	*/
	static resetState = function() {
		if (stateSwitchIsLocked) return;
		
		stateShouldReset = true;
		isNewState = true;
	}
	
	/**
	* Switch to the previous state
	*
	* @return void
	*/
	static statePrevious = function() {
		if (stateSwitchIsLocked) return;
		
		// Switch to original state if stack is empty
		if (!ds_size_size(stateStack)) {
			switchState(originalState.id);
			isNewState = true;
			return;
		}
		
		// Remove last state in the stack
		ds_stack_pop(stateStack);
		stateSwitchIsLocked = true;
		
		// Switch the state to the first state found within the stack
		isNewState = true;
		switchState(ds_stack_top(stateStack));
	}
	
	/**
	* Clear state history
	*
	* @return void
	*/
	static clearStateHistory = function() {
		// Clear history of states
		stateHistory = ds_stack_clear(stateHistory);
		
		// Add active state to history
		addHistory(activeState);
	}
	
	/**
	* Add state to history
	*
	* @return void
	*/
	static addHistory = function(state) {
		ds_stack_push(stateHistory, state.name);
	}
	
	/**
	* Fire a specfic event - must be found within StateMemoryEvent
	*
	* @return void
	*/
	static event = function(event) {
		var state = activeState;
		
		// Set active state to original state if there is not an active state
		if (state == undefined) {
			isNewState = true;
			activeState = originalState;
			event(StateMemoryEvent.Enter);
			return;
		}
		
		switch (event) {
			case StateMemoryEvent.SwitchState:
				stateSwitchIsLocked = false;
				stateTimer ++;
				
				if (nextState == activeState && !stateShouldReset) {
					isNewState = false;
					return;
				}
				
				stateShouldReset = false;
				
				var stateFunction = activeState.func;
				
				with (instanceOwner) {
					if (stateFunction != undefined) {
						stateFunction(StateMemoryEvent.Exit, other);
					}
				}
				
				previousState = activeState;
				activeState = nextState;
				
				addHistory(activeState);
				stateTimer = 0;
				
				stateFunction = activeState.func;
				with (instanceOwner) {
					isNewState = true;
					stateFunction(StateMemoryEvent.Enter, other);
				}
				return;
			break;
			default:
		        var stateFunction = activeState.func;
		        with(instanceOwner) {
					stateFunction(event, other); 
		        }
		    break;	
		}
	}
}