// Menu background
draw_sprite_stretched_ext(
	spr_hud,
	0,
	vw,
	vh,
	hud_width,
	hud_height,
	-1,
	1
);


if (!surface_exists(surf)) {
   surf = surface_create(actual_width,actual_height); // Create the surface if it doesn't exist
}

surface_set_target(surf); // Set the drawing target to our menu surface
draw_set_valign(fa_top);
draw_set_halign(fa_left); // Setup text

text = "List item";
text_height = string_height(text);


mx = mouse_x/scale; // Mouse x position in window
my = (mouse_y/scale)-start_y-(text_height * 1.5); // Mouse y position in relation to the menu system

for (var i = 0; i < menu_options; i++) { // Loop through and create each menu item
	
	var position = i;
	var alert_x_pos = 0;
	var alert_y_pos = text_height*i;
	// Center align text
	var text_y_center = alert_y_pos + text_height / 3.25;
	var text_x_center = padding;
	
		
	var alert_width = actual_width;
	var alert_height = text_height * 1.5;
	var font_sep = text_height/2;
	var padding_top = text_height/4;
		
	var alert_height_pos = (font_sep) * (position);
	
	xl = start_x;
	xr = start_x+draw_width;
	yt = -surf_ypos+(alert_y_pos + alert_height_pos);
	yb = -surf_ypos+((alert_y_pos + alert_height_pos) + alert_height); // We need these to set the coordinates for our mouse check (xl = left x, yt = top y, etc)
	col = c_black;
	if (point_in_rectangle(mx,my,xl,yt,xr,yb)) {
		col = c_blue; // If the mouse is hovering over one of these options, relative to where the menu has been scrolled to then change the colour
	}
	
	// Draw alert container with effects
	draw_sprite_stretched_ext(
		spr_list_item,
		0,
		0,
		alert_y_pos + alert_height_pos,
		alert_width,
		alert_height + padding_top,
		-1,
		1
	);
	
	// Draw centered alert message
	draw_text_ext_color(
		text_x_center,
		text_y_center + alert_height_pos,
		string(text) + " " + string(i),
		text_height + font_sep,
		draw_width,
		col,col,col,col,
		1
	);
}
surface_reset_target(); // Reset the draw target back to the application_surface

draw_set_color(c_grey);
draw_rectangle(start_x,start_y,start_x+draw_width,start_y+menu_height,false);

var col = c_white;
mx = mouse_x/scale;
my = mouse_y/scale; // Mouse positions, no need to relate it to the surface this time as it's for our Menu button
if (point_in_rectangle(mx,my,start_x,start_y,start_x+draw_width,start_y+menu_height)) { // If the mouse is within the Menu button
   col = c_yellow; // Change the colour variable to yellow to show it's selected
   if (mouse_check_button_released(mb_left)) { // If the user clicks
      menu_on = !menu_on; // Set menu to the opposite of what it was (if it was true, it is now false, if it was false, it is now true)
   }
}
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(col); // Setup text
draw_text(start_x+(draw_width/2),start_y+(menu_height/2),"Todo List"); // Draw our Menu button text
if (menu_on) { // If the Menu button has been clicked and our menu is active
   if (point_in_rectangle(mouse_x/scale,mouse_y/scale,start_x,start_y+menu_height,start_x+draw_width,start_y+menu_height+draw_height)) { // If the mouse is within the coordinates where we are drawing our menu surface
      if (mouse_wheel_up() || keyboard_check(vk_up)) { // If the user scrolls up
          if (surf_ypos > 0) { // Surf_ypos stores where the 'upper' position that we should be cutting off our menu surface is when we scroll, and if this is greater than 0
              surf_ypos -= scroll_chunk; // Take a scroll_chunk out of the surf_ypos, which'll make the menu surface that is being drawn scroll down
          }
          if (surf_ypos < 0) { // If the surf_ypos is lower than 0 we want to reset it back to 0 (so that we can't scroll past the top of the menu)
              surf_ypos = 0;
          }
      }
      if (mouse_wheel_down() || keyboard_check(vk_down)) { // Same as above for scrolling down
          if (surf_ypos+draw_height < actual_height) {
              surf_ypos += scroll_chunk;
          }
          if (surf_ypos+draw_height > actual_height) {
              surf_ypos = actual_height-draw_height;
          }
      }
   }
   draw_surface_part(surf,0,surf_ypos,draw_width,draw_height,start_x,start_y+menu_height);
   /* Finally, draw our surface. The top argument tells the computer what part of the surface to
   start drawing from (in the y axis), so by setting it to surf_ypos, we allow the above scrolling
   code to change what part of the surface is being drawn. Then we simply plug in the width and
   height we want section of the menu surface that is being shown to be and finally position it
   just under our Menu button */
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);