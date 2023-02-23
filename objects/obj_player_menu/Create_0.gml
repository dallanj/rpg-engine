// Menu wrapper
hud_scale_x = 1;
hud_scale_y = 2;
hud_width = sprite_get_width(spr_hud) * hud_scale_x;
hud_height = sprite_get_height(spr_hud) * hud_scale_y;
vw = (view_xport[0] + view_wport[0] / 2) - (hud_width / 2);
vh = (view_yport[0] + view_hport[0] / 2) - (hud_height / 2);
padding = 15;

surf = -1;

menu_on = true; // Whether we are showing the menu or not
surf_ypos = 0; // This is used to tell the computer where to cut off the menu surface being drawn when we are scrolling
menu_options = 50; // How many menu options in the popup menu box

actual_width = hud_width - (padding*2); // Width of the menu surface
draw_width = hud_width - (padding*2); // Width of the section of menu we are drawing

start_x = vw + padding;
start_y = vh + padding; // The start x and y position for the whole menu system

menu_height = 60; // How high each menu item is
scroll_chunk = 15; // How much we scroll by when we scroll
actual_height = menu_height*menu_options; // Height of the menu surface
draw_height = min(hud_height - (padding*2) - menu_height,actual_height); // Height of the section of menu we are drawing
scale = camera_get_view_width(view_camera[0])/display_get_gui_width(); // Use this if you are drawing in Draw GUI otherwise, set it to 1