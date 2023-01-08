/// @description Variables
player = new Player();

//image_speed = player.state.Fps;
//image_index = player.state.sprites[0];

// State
this = generateStateMemory();
this.addState(State.idle, characterStateIdle, "idle");
this.addState(State.walk, characterStateWalk, "walk");