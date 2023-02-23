/// @description

// Increase alpha by alpha_timer each frame
if (dialog_alpha < max_alph) {
	dialog_alpha += alph_timer;
}

// Detect if player is clicking the dialog arrow button
if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), vw  + (dialog_width / 2) - 75, vh + 285,  vw  + (dialog_width / 2) - 40, (vh + 285) + 30) {
	if (mouse_check_button_pressed(mb_left) && (dialog_alpha >= max_alph) && display_choices == false) {
		skipDialog();
	}
}

// Choice selection dialog
if (display_choices && (dialog_alpha >= max_alph)) {
	for (var i = 0; i < array_length(data[text_current].choices); i++) {
		// Input from player
		var input = false;
		
		// Click choices - mouse event
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), text_x, text_y + (i * 32), text_x + (dialog_width) - 175, text_y + ((i + 1) * 32)) {
			if (mouse_check_button_pressed(mb_left) && (dialog_alpha >= max_alph)) {
				input = true;
			}
		}
		
		// Keybind choices - keyboard event
		for (var j = 0; j < array_length(data[text_current].choices); j++) {
			if (keyboard_check_pressed(ord(data[text_current].choices[i].choice))) {
				input = true;
			}
		}
		
		// If player made a choice
		if (input) {
			// Run dialog scripts if there are any
			if (data[text_current].choices[i].before != noone) {
				runDialogScript(data[text_current].choices[i].before);	
			}
			
			// Disable choice selection
			display_choices = false;
			test[text_current] = data[text_current].choices[i].dialog;
			test[text_current] = string_wrap(test[text_current], text_width);
			char_current = 0;
		}
	}
}


