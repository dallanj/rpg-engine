// Scale the sprite images
dialog_scale = 0.4;
character_scale = 0.5;

// Dialog sprite dimensions
dialog_width = sprite_get_width(spr_dialog_box) * dialog_scale;
dialog_height = sprite_get_height(spr_dialog_box) * dialog_scale;

// Font and text settings
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
text_height = string_height(text);
dialog_font = font_add("Gaegu-Regular.ttf", 28, false, false, 32, 128);
name_font = font_add("Fredoka-VariableFont_wdth,wght.ttf", 24, false, false, 32, 128);
name_color = make_color_rgb(29.8, 29.8, 74.5);

// Dialog settings
has_right_character = true;
display_choices = false;

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
alph_timer = .03;
