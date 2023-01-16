/**
* Npc controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function npcStateIdle(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
			if (stateLayer.isNewState) {
				image_speed = 0;
				image_index = self.character.sprites[0];
				show_debug_message("begin idle state for npc");
			}
		break;
		case StateMemoryEvent.Step:
			//
		break;
		case StateMemoryEvent.DrawGui:
			//
		break;
	};
}