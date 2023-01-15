/// @description Init player
player = new Player();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, characterStateIdle, "idle");
this.addState(State.walk, characterStateWalk, "walk");
//this.addState(State.walk, characterStateWalk, "cutscene");
//this.addState(State.walk, characterStateWalk, "dialog");

/* Actions
* W,A,S,D
* SHIFT (run)
* SPACE (interact)
* G (drop item)
* E (enter buildings)
* C (combine items)
*/
this.event(StateMemoryEvent.Enter);
