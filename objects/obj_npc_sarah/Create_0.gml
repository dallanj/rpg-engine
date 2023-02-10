/// @description
character = new Sarah();

// State
this = generateStateMemory();

// Player states
this.addState(State.idle, npcStateIdle, "idle");
this.addState(State.walk, npcStateWalk, "walk");

this.event(StateMemoryEvent.Enter);

ai_right = 1;
iframe = 0;
ai_left = 0;
ai_speed = 1;
npc_direction = 3;