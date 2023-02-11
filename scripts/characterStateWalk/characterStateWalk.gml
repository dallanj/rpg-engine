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
			var position_free = true;
			var characterSpeed = self.player.walkingSpeed;
			var characterImageSpeed = self.player.walkingImageSpeed;
			var characterControls = self.player.controls;
			var characterFrames = self.player.frames;
			
			// Update current active keys
			self.player.sprites = characterUpdateKeys(characterControls, self.player.keys, characterFrames, self.player.sprites);
			
			// Adjust character speeds if walking or running
			if (characterCheckKeys(characterControls)) {
				if (keyboard_check(vk_shift)) {
					characterSpeed = self.player.runningSpeed;
					characterImageSpeed = self.player.runningImageSpeed;
				} else {
					characterSpeed = self.player.walkingSpeed;
					characterImageSpeed = self.player.walkingImageSpeed;
				}
			}
			
			// Loop through sprite image indexes in players state
			characterAnimation(self.player.sprites, characterImageSpeed);
			
			// Left movement
			if characterKeyboard("A") {
				position_free = characterMovement(sign(characterSpeed * -1), characterSpeed * -1, obj_wall);
			}

			// Right movement
			if characterKeyboard("D") {
				position_free = characterMovement(sign(characterSpeed), characterSpeed, obj_wall);
			}

			// Up movement
			if characterKeyboard("W") {
				position_free = characterMovement(sign(characterSpeed * -1), characterSpeed * -1, obj_wall, true);
			}

			// Down movement
			if characterKeyboard("S") {
				position_free = characterMovement(sign(characterSpeed), characterSpeed, obj_wall, true);
			}
		
			
			// If character is not moving or position is not clear
			if (!position_free || !characterCheckKeys(characterControls)) {
				// Clear active keys
				self.player.keys = [];
				
				// Switch character to idle state
				stateLayer.switchState(State.idle);	
			}

		break;
		case StateMemoryEvent.DrawGui:
			//characterDrawGui(self.player, stateLayer);
		break;
	};
}