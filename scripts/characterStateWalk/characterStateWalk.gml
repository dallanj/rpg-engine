/**
* Character controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function characterStateWalk(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
			if (stateLayer.isNewState) {
				show_debug_message("begin walking state");
			}
		break;
		case StateMemoryEvent.Step:
			// Update current active keys
			self.player.state.sprites = characterUpdateKeys(self.player.controls, self.player.state.keys, self.player.frames, self.player.state.sprites);
			
			// Loop through sprite image indexes in players state
			characterAnimation(self.player.state.sprites, self.player.Fps);
			
			// If character is not moving
			if (!characterCheckKeys(self.player.controls)) {
				// Clear active keys
				self.player.state.keys = [];
				
				// Switch character to idle state
				stateLayer.switchState(State.idle);	
			}
			
			// Left movement
			if characterKeyboard("A") {
				characterMovement(sign(self.player.state.Speed * -1), self.player.state.Speed * -1, obj_wall);
			}

			// Right movement
			if characterKeyboard("D") {
				characterMovement(sign(self.player.state.Speed), self.player.state.Speed, obj_wall);
			}

			// Up movement
			if characterKeyboard("W") {
				characterMovement(sign(self.player.state.Speed * -1), self.player.state.Speed * -1, obj_wall, true);
			}

			// Down movement
			if characterKeyboard("S") {
				characterMovement(sign(self.player.state.Speed), self.player.state.Speed, obj_wall, true);
			}

		break;
		case StateMemoryEvent.DrawGui:
			characterDrawGui();
		break;
	};
}