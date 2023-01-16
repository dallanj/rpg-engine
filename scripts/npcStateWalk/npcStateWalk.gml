/**
* NPC controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function npcStateWalk(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
			if (stateLayer.isNewState) {
				show_debug_message("begin walking state for npc");
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