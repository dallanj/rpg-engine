
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

draw_sprite_ext(spr_dialog_arrow, 0, vw  + (dialog_width / 2) - 70 , vh + dialog_height + 50, 0.5, 0.5, 0, -1, dialog_alpha);

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
	var _len = string_length(test[text_current]);
	if (char_current < _len) {
		char_current += char_speed;
	}
	
	var _str = string_copy(test[text_current], 1, char_current);
	draw_text_ext(text_x, text_y, _str, text_height + 10, dialog_width - 80);
}

draw_text(6,30,"text_current = " + string(text_current));
draw_text(6,60,"text_last = " + string(text_last));
//draw_text_ext(vw  - (dialog_width / 2) + 80, vh + 170, text, text_height + 14, dialog_width - 80);

//font_delete(new_font);
//draw_set_color(c_red);
//draw_text(0, 80, "OPACITY: " + string(opacity));

//for (i = 0; i <= word_count; i += 1) {
//	//show_message(words_array[i]);
//	for (j = 0; j < string_length(words[i]); j += 1) {
//		//show_message(words_array[i][j]);
//		//while (opacity >= 100) {
//			//show_message("ONE");
//			//draw_text(100, 80, "OPACITY: " + string(opacity));

//			draw_text_ext_colour(vw  - (dialog_width / 2) + 80, vh + 170, words_array[i][j], text_height + 14, dialog_width - 80, c_white, c_white, c_white, c_white, opacity);
//		//}
		
//		//opacity = 0;
//	}
//}
//draw_rectangle(vw  + (dialog_width / 2) - 75, vh + 285,  vw  + (dialog_width / 2) - 40, (vh + 285) + 30, true)