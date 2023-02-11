// Draw inventory HUD
//draw_sprite(spr_dialog_daniel, 0, vw_character_right, vh_character + 500);
//draw_sprite_ext(spr_dialog_daniel, 0, view_xport[0], view_yport[0], 0.5, 0.5, 0, -1, 1);
//draw_sprite_ext(spr_dialog_daniel, 0, view_xport[0], view_yport[0], 0.5, 0.5, 0, -1, 1);

//draw_sprite_ext(spr_dialog_daniel, 0, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), 0.5, 0.5, 0, -1, 1);

// For characters speaking on the right side
draw_sprite_ext(spr_dialog_luna, 0, vw - 700, view_yport[0], character_scale, character_scale, 0, -1, 1);
draw_sprite_ext(spr_dialog_daniel, 0, vw + 160, view_yport[0], character_scale, character_scale, 0, -1, 1);
draw_sprite_ext(spr_dialog_box, 0, vw  - (dialog_width / 2), vh + 100, dialog_scale, dialog_scale, 0, -1, 1);
draw_sprite_ext(spr_dialog_name_tag, 0, vw  - (dialog_width / 2) + 70, vh + 95, 0.75, 0.75, 0, -1, 1);
draw_sprite_ext(spr_dialog_arrow, 0, vw  + (dialog_width / 2) - 70 , vh + dialog_height + 50, 0.5, 0.5, 0, -1, 1);

// Draw text
draw_set_font(dialog_font);
draw_text_ext(vw  - (dialog_width / 2) + 80, vh + 170, text, text_height + 14, dialog_width - 80);

// Draw name
draw_set_color(name_color);
draw_set_font(name_font);
draw_text_ext(vw  - (dialog_width / 2) + 110, vh + 105, "Daniel Lim", text_height + 14, dialog_width - 80);

//font_delete(new_font);