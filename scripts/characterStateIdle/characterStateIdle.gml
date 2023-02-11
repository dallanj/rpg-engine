/**
* Character controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function characterStateIdle(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
			if (stateLayer.isNewState) {
				image_speed = 0;
				image_index = self.player.sprites[0];
				show_debug_message("begin idle state");
			}
		break;
		case StateMemoryEvent.Step:
			if (characterCheckKeys(self.player.controls)) {
				stateLayer.switchState(State.walk);
			}
		break;
		case StateMemoryEvent.DrawGui:
			//characterDrawGui(self.player, stateLayer);
		break;
	};
}