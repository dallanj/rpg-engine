/// @description
obj_data = new Bob();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, npcStateIdle, "idle");
this.addState(State.walk, npcStateWalk, "walk");
this.event(StateMemoryEvent.Enter);
depth = -bbox_bottom;