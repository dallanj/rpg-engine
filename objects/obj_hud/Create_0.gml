/// @description Init HUD settings
global.max_days = 7; // Max amount of days allowed per game
global.total_days = 6;
global.day = 5; // Monday = 0
global.hours = 22; // Hours 0 - 24
global.minutes = 60; // Minutes 0 - 60
global.reputation = 100; // Reputation 0-100
global.currency = 0; // # of dollars

// HUD sprite dimensions
hud_width = sprite_get_width(spr_hud);
hud_height = sprite_get_height(spr_hud);

// Viewport positions
vw = camera_get_view_width(view_camera[0]) - hud_width;
vh = 0;

// Variables
text_x_pos = vw + 25;
text_y_pos = vh + 25;
real_time = 0.5; // Real time in seconds

// Update time
alarm[0] = real_time * room_speed; // Every second