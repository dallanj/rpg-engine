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
			image_speed = player.state.Fps;
			image_index = player.state.sprites[0];
		break;
		case StateMemoryEvent.Step:
			if (keyboard_check_pressed(vk_anykey)) {
				stateLayer.switchState(State.walk);
			}
		case StateMemoryEvent.DrawGui:
			draw_set_color(c_white);
			draw_text(20,20,string_hash_to_newline("State: "+string(stateLayer.activeState)
              +"#previous: "+string(stateLayer.previousState))
         );
		break;
		case StateMemoryEvent.Exit:
			exit;
		break;
			//
	};
}