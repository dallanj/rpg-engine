/// @description
item = new DanielJournal();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, dialogItemIdle, "idle");

this.event(StateMemoryEvent.Enter);
