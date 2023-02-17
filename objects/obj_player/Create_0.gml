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
* W,A,S,D (done)
* SHIFT (run) (done)
* G (drop item) (done)
* C (combine items)
* SPACE (interact)
*/
this.event(StateMemoryEvent.Enter);