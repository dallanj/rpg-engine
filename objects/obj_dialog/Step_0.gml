/// @description Insert description here
// You can write your code in this editor
if (dialog_alpha < max_alph) {
	dialog_alpha += alph_timer; // Increase alpha by alpha_timer each frame
}

// Detect if cursor is hovering over a slot
if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), vw  + (dialog_width / 2) - 75, vh + 285,  vw  + (dialog_width / 2) - 40, (vh + 285) + 30) {
	if (mouse_check_button_pressed(mb_left) && (dialog_alpha >= max_alph)) {
		// Skip dialog
		var length = string_length(test[text_current]);
		if (char_current < length) {
		    char_current = length;
		} else {
		    text_current += 1;
		    if (text_current > text_last){
		        room_restart();
			} else {
		        test[text_current] = string_wrap(test[text_current], text_width);
		        char_current = 0;
			}
		}
	}
}
