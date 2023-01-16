/**
* Draw npc state for testing only
*
* @param state (struct)
* @param stateLayer (struct)
*
* @return void
*/
function npcDrawGui(state, stateLayer, x_pos) {
	draw_set_color(c_white);
	draw_text(x_pos,20,string_hash_to_newline("State: "+string(stateLayer.activeState.name)
        +"#previous: "+string(stateLayer.previousState.name)
		+"#keys: "+string(state.keys)
		+"#sprites: "+string(state.sprites)
		+"#name: "+string(state.sprites))
    );
	
	return;
};