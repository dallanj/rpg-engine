alert = ALERT;

// Viewport positions
vw = noone;
vh = noone;

// Initial alert positioning
alert_x_pos = 0;
alert_y_pos = 0;

// Font settings
font_size = 18;
font_sep = font_size / 2;
font_color = make_color_rgb(29.8, 29.8, 74.5);

// Regular
//alert_font = font_add("Fredoka-Regular.ttf", font_size, false, false, 32, 128);
// Medium
//alert_font = font_add("Fredoka-Medium.ttf", font_size, false, false, 32, 128);
// SemiBold
alert_font = font_add("Fredoka-SemiBold.ttf", font_size, false, false, 32, 128);
// Bold
//alert_font = font_add("Fredoka-Bold.ttf", font_size, false, false, 32, 128);

// Initialize variables
text_height = 0;
text_width = 0;

// Fade effect
alpha = 0;
max_alph = 1;
effect_timer = .06;
alert_active = true;

// Hovering effect
hover_timer = 0;

// Shifting effect
shifting = 0;

// Time for alert
number_of_alarms = noone;
paused_alarms = noone;
alarm[0] = alert.time * room_speed;

