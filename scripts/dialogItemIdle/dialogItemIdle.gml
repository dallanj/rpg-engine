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
						
						var unclaimed_rewards = self.obj_data.unclaimed_rewards;
						
						// Find quests by NPC
						var quests = getQuestsByNpc(self.obj_data.object);
						
						// Reward player with unclaimed items
						if (array_length(unclaimed_rewards) > 0) {
							unclaimed_rewards = claimRewards(unclaimed_rewards);
						}
						
						// Reward player with unclaimed quest items
						claimQuestRewards(quests);

						// Check if quests have unclaimed rewards
						var num_of_quest_rewards = hasUnclaimedQuestRewards(quests);
						
						// Check if npc has unclaimed rewards
						var num_of_rewards = hasUnclaimedRewards(unclaimed_rewards);
						
						var total_rewards = num_of_quest_rewards + num_of_rewards;
						
						if (total_rewards > 0) {
							var msg = "You have unclaimed rewards, come back when you have " + string(total_rewards) + " inventory spaces.";
							dialog.text_last = 0;
							dialog.data[0] = ["Daniel Lim","right",msg,noone,noone,noone,spr_dialog_daniel];
							dialog.test[0] = msg;
						} else {
							dialog.text_last = array_length(self.obj_data.dialog_script[self.obj_data.dialog_current]) - 1;
							for (i = 0; i <= dialog.text_last; i++) {
								dialog.data[i] = self.obj_data.dialog_script[self.obj_data.dialog_current][i];
								dialog.test[i] = self.obj_data.dialog_script[self.obj_data.dialog_current][i][2];
							}
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