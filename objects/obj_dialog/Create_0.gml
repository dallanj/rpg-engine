dialog_scale = 0.4;
character_scale = 0.5;

dialog_width = sprite_get_width(spr_dialog_box) * dialog_scale;
dialog_height = sprite_get_height(spr_dialog_box) * dialog_scale;

text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
text_height = string_height(text);
dialog_font = font_add("Gaegu-Regular.ttf", 28, false, false, 32, 128);
name_font = font_add("Fredoka-VariableFont_wdth,wght.ttf", 24, false, false, 32, 128);
name_color = make_color_rgb(29.8, 29.8, 74.5);
has_right_character = true;

// Centering based on view ports
vw = view_xport[0] + view_wport[0] / 2;
vh = view_yport[0] + view_hport[0] / 2;

// Type writer text
test[0] = "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
text_current = 0;
text_last = 0;
text_width = 300;
text_x = vw  - (dialog_width / 2) + 80;
text_y = vh + 170;
char_current = 1;
char_speed = 0.5;
text[text_current] = string_wrap(test[text_current], text_width);

// Fade in transition
dialog_alpha = 0;
max_alph = 1;
alph_timer = .01;

//word_count = string_count(" ",test);
//words = ExplodeString(test);


//// Array containing an array of characters
//words_array = [];

//// Break down each word by character
//for (i = 0; i <= word_count; i += 1) {
//	//show_message(string(words[i]));
//	chars_array = [];
//	for (j = 1; j <= string_length(words[i]); j += 1) {
//		array_push(chars_array, string_char_at(words[i], j));
//	}
//	array_push(words_array, chars_array);
//}

//alarm[0] = 1 * room_speed;
//opacity = 0;

//dialog_height = sprite_get_height(spr_dialog_box);
//inventory_width = sprite_get_width(spr_dialog_daniel);
//inventory_height = sprite_get_height(spr_dialog_daniel);

// Viewport positions
//vw_character_right = (camera_get_view_width(view_camera[0])) - inventory_width;
//vw_character_right = (camera_get_view_width(view_camera[0])) - inventory_width;
//vh_character = camera_get_view_width(view_camera[0]) - inventory_height * 1.425;

