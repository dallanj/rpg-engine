/// @description
character = new Sarah();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, npcStateIdle, "idle");
this.addState(State.walk, npcStateWalk, "walk");

this.event(StateMemoryEvent.Enter);
