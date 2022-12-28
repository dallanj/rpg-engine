
/// @description Collide
// You can write your code in this editor

//other.x = xPosition;
//other.y = yPosition;
//room_goto(roomName);

warp = instance_create_depth(x, y, depth - 100, obj_warpController);
warp.newX = xPosition;
warp.newY = yPosition;
warp.newRoom = roomName;

////show_debug_message("collide");

instance_destroy();