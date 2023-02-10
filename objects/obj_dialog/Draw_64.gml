// Draw inventory HUD
//draw_sprite(spr_dialog_daniel, 0, vw_character_right, vh_character + 500);
//draw_sprite_ext(spr_dialog_daniel, 0, view_xport[0], view_yport[0], 0.5, 0.5, 0, -1, 1);
//draw_sprite_ext(spr_dialog_daniel, 0, view_xport[0], view_yport[0], 0.5, 0.5, 0, -1, 1);

//draw_sprite_ext(spr_dialog_daniel, 0, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), 0.5, 0.5, 0, -1, 1);

draw_sprite_ext(spr_dialog_daniel, 0, vw + 160, view_yport[0], character_scale, character_scale, 0, -1, 1);
draw_sprite_ext(spr_dialog_box, 0, vw  - (dialog_width / 2), vh + 100, dialog_scale, dialog_scale, 0, -1, 1);

//view_get_xport()
