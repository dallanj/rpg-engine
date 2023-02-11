dialog_scale = 0.4;
character_scale = 0.5;

dialog_width = sprite_get_width(spr_dialog_box) * dialog_scale;
dialog_height = sprite_get_height(spr_dialog_box) * dialog_scale;

text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
text_height = string_height(text);
dialog_font = font_add("Gaegu-Regular.ttf", 28, false, false, 32, 128);
name_font = font_add("Fredoka-VariableFont_wdth,wght.ttf", 24, false, false, 32, 128);
name_color = make_color_rgb(29.8, 29.8, 74.5);

vw = view_xport[0] + view_wport[0] / 2;
vh = view_yport[0] + view_hport[0] / 2;

//dialog_height = sprite_get_height(spr_dialog_box);
//inventory_width = sprite_get_width(spr_dialog_daniel);
//inventory_height = sprite_get_height(spr_dialog_daniel);

// Viewport positions
//vw_character_right = (camera_get_view_width(view_camera[0])) - inventory_width;
//vw_character_right = (camera_get_view_width(view_camera[0])) - inventory_width;
//vh_character = camera_get_view_width(view_camera[0]) - inventory_height * 1.425;

