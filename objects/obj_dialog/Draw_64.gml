
// Draw characters speaking on the left side
if (has_right_character) {
	draw_sprite_ext(spr_dialog_luna, 0, vw - 700, view_yport[0], character_scale, character_scale, 0, -1, dialog_alpha);
}

// Draw characters speaking on the left side
draw_sprite_ext(spr_dialog_daniel, 0, vw + 160, view_yport[0], character_scale, character_scale, 0, -1, dialog_alpha);

// Draw dialog box
if (data[text_current][1] == "right") {
	draw_sprite_ext(spr_dialog_box, 0, vw  - (dialog_width / 2), vh + 100, dialog_scale, dialog_scale, 0, -1, dialog_alpha);	
	draw_sprite_ext(spr_dialog_name_tag, 0, vw  - (dialog_width / 2) + 70, vh + 95, 0.75, 0.75, 0, -1, dialog_alpha);
} else {
	draw_sprite_ext(spr_dialog_box_left, 0, vw  - (dialog_width / 2), vh + 100, dialog_scale, dialog_scale, 0, -1, dialog_alpha);
	draw_sprite_ext(spr_dialog_name_tag, 0, vw + 150, vh + 95, 0.75, 0.75, 0, -1, dialog_alpha);
}

if (display_choices == false) {
	draw_sprite_ext(spr_dialog_arrow, 0, vw  + (dialog_width / 2) - 70 , vh + dialog_height + 50, 0.5, 0.5, 0, -1, dialog_alpha);
}

// Draw name
draw_set_font(name_font);
if (data[text_current][1] == "right") {
	draw_text_ext_color(vw  - (dialog_width / 2) + 110, vh + 105, data[text_current][0], text_height + 14, dialog_width - 80, name_color, name_color, name_color, name_color, dialog_alpha);
} else {
	draw_text_ext_color(vw + 180, vh + 105, data[text_current][0], text_height + 14, dialog_width - 80, name_color, name_color, name_color, name_color, dialog_alpha);
}

// Draw text
draw_set_font(dialog_font);
draw_set_color(c_white);
if (dialog_alpha >= max_alph) {
	
	if (display_choices) {
		//show_message(data[text_current][5][0]);
		for (i = 0; i < array_length(data[text_current][5]); i++) {
			//show_message(data[text_current][5][i][1]);
			draw_text(text_x, text_y + (i * 32),string(data[text_current][5][i][0]) + ". " + string(data[text_current][5][i][1]));
		}
	} else {
		var _len = string_length(test[text_current]);
		if (char_current < _len) {
			char_current += char_speed;
		}
	
		var _str = string_copy(test[text_current], 1, char_current);
		draw_text_ext(text_x, text_y, _str, text_height + 10, dialog_width - 80);
	}
}

//draw_text(6,30,"text_current = " + string(text_current));
//draw_text(6,60,"text_last = " + string(text_last));

//if (display_choices && (dialog_alpha >= max_alph)) {
//	for (i = 0; i <= array_length(data[text_current][5]); i++) {
//		draw_rectangle(text_x, text_y + (i * 32), text_x + (dialog_width) - 175, text_y + ((i + 1) * 32), true);
//	}
//}