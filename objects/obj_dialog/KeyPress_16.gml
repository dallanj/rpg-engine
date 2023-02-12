// Skip dialog
if (dialog_alpha >= max_alph) {
	var length = string_length(test[text_current]);
	if (char_current < length) {
		char_current = length;
	} else {
		text_current += 1;
		if (text_current > text_last){
		    instance_destroy(self);
		} else {
			// If choice based dialog
			if (test[text_current] == noone) {
				//show_message(data[text_current]);
				
				if (data[text_current][5] == noone) {
					instance_destroy(self);	
				} else {
					display_choices = true;
				}
				
			} else {
				test[text_current] = string_wrap(test[text_current], text_width);
				char_current = 0;
			}
		}
	}
}
