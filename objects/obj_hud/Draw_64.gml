/// @description Draw HUD
draw_set_font(font_hud);

if (!global.dialog_exists) {
	// Draw HUD

	// For every 60 minutes; update hour
	if (global.minutes == 60) updateHour();

	// For every 24 hours; update day
	if (global.hours == 24) updateDay();

	// Date formats
	var day = getDayString();
	var hours = formatTime(global.hours);
	var minutes = formatTime(global.minutes);

	// Draw day of the week and current time
	var time = day + ", " + hours + ":" + minutes;
	var date = " (day " + string(global.total_days) + ")";
	DrawTextOutlined(text_x_pos, text_y_pos, c_black, c_white, time, desc_font);
	DrawTextOutlined(text_x_pos + 175, text_y_pos + (30 * 0), c_black, c_white, date, desc_font);

	// Draw reputation bar
	var reputation = "Reputation: " + string(global.reputation);
	DrawTextOutlined(text_x_pos, text_y_pos + (30 * 1), c_black, c_white, reputation, desc_font);

	// Draw currency
	var currency = "Currency: " + string(global.currency);
	DrawTextOutlined(text_x_pos, text_y_pos + (30 * 2), c_black, c_white, currency, desc_font);
	
	// Draw currency
	var inventory_slots = "Inventory Slots: " + string(obj_player.player.inventory_slots);
	draw_text(text_x_pos, text_y_pos + (30 * 3), inventory_slots);
	
	// Draw quests (temporary placement)
	count = 4;
	var quest_name = "";
	//show_message(variable_struct_get_names(global.quests));
	// Iterate over each key in the quest_list struct
	var quest_keys = variable_struct_get_names(global.quests);
	//show_message(string(quest_keys));
	for (var i = 0; i < array_length(quest_keys); i++) {
		//show_message(global.quests.quest_keys[i]);
	    // Get the current key
	    var current_key = quest_keys[i];
    
	    // Access the struct at the current key
	    var current_quest = global.quests[$ current_key];
    
	    // Get the quest name and display it
	    quest_name = current_quest.name;
	    //draw_text(text_x_pos, text_y_pos + (30 * 0) * quest_count, "Quest " + ": " + quest_name);
    
		draw_text(text_x_pos, text_y_pos + (30 * count),string_hash_to_newline("Quest: "+string(current_quest.name)
	        +"#started: "+string(current_quest.started)
			+"#completed: "+string(current_quest.completed)
			//+"#rewards: "+string(current_quest.rewards)
	    ));
	    // Increment the quest count
	    count = count + 3;
	}
}