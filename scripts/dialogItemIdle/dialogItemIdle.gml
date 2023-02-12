/**
* Npc controller for in a state of idle
*
* @param event (enum)
*
* @return void
*/
function dialogItemIdle(event, stateLayer) {
	switch (event) {
		case StateMemoryEvent.Enter:
			if (stateLayer.isNewState) {
				show_debug_message("begin idle state for npc");
			}
		break;
		case StateMemoryEvent.Step:
		
			// Dialog box
			if (distance_to_object(obj_player) < 5) {
				if (keyboard_check_pressed(vk_space)) {
					if (!instance_exists(obj_dialog)) {
						dialog = instance_create_layer(x, y, "dialog", obj_dialog);
						dialog.has_right_character = false;
						dialog.text_current = 0;
						dialog.text_last = array_length(self.obj_data.dialog_script) - 1;
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
			//draw_text(200,100,"dialog box = " + string(dialog_toggle));
		break;
	};
}