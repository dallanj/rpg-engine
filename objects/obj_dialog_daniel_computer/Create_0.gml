/// @description
item = new DanielComputer();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, dialogItemIdle, "idle");

this.event(StateMemoryEvent.Enter);
