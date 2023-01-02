/// @description Update time
// Add a minute for every second passed
global.minutes ++;

// Reset alarm
alarm[0] = real_time * room_speed;