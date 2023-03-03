
warp = instance_create_depth(x, y, depth - 1000, obj_warpController);
warp.newX = xPosition;
warp.newY = yPosition;
warp.newRoom = roomName;

instance_destroy();