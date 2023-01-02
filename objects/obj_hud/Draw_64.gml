/// @description Draw HUD
draw_set_font(font_hud);

// Draw HUD
draw_sprite(spr_hud, 0, vw, vh);

// For every 60 minutes; update hour
if (global.minutes == 60) updateHour();

// For every 24 hours; update day
if (global.hours == 24) updateDay();

// Date formats
var day = getDayString();
var hours = formatTime(global.hours);
var minutes = formatTime(global.minutes);

// Draw day of the week and current time
var date = day + ", " + hours + ":" + minutes + " - (day " + string(global.total_days) + ")";
DrawTextOutlined(text_x_pos, text_y_pos, c_black, c_white, date);

// Draw reputation bar
var reputation = "Reputation: " + string(global.reputation);
DrawTextOutlined(text_x_pos, text_y_pos + 50, c_black, c_white, reputation);

// Draw currency
var currency = "Currency: " + string(global.currency);
DrawTextOutlined(text_x_pos, text_y_pos + 100, c_black, c_white, currency);