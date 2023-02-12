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
				image_index = self.obj_data.sprites[0];
				show_debug_message("begin idle state for npc");
			}
		break;
		case StateMemoryEvent.Step:
		
			// Dialog box
			if (distance_to_object(obj_player) < 5) {
				if (keyboard_check_pressed(vk_space)) {
					if (!instance_exists(obj_dialog)) {
						dialog = instance_create_layer(x, y, "dialog", obj_dialog);
						dialog.text_current = 0;
						dialog.text_last = array_length(self.obj_data.dialog_script[self.obj_data.dialog_current]) - 1;
						for (i = 0; i <= dialog.text_last; i++) {
							dialog.data[i] = self.obj_data.dialog_script[self.obj_data.dialog_current][i];
							dialog.test[i] = self.obj_data.dialog_script[self.obj_data.dialog_current][i][2];
						}
					}
				}
				
				if (characterCheckKeys(["W","A","S","D"])) {
					if (instance_exists(obj_dialog)) {
						instance_destroy(obj_dialog);
					}
				}
			}
		break;
		case StateMemoryEvent.DrawGui:
			
		break;
	};
}