// Store map instances and their data when leaving the current room
saveMapInstances();

// Create new warp instance with given room and spawn coords
warp = instance_create_depth(x, y, depth - 1000, obj_warpController);
warp.newX = xPosition;
warp.newY = yPosition;
warp.newRoom = roomName;

// Create used warp instance
instance_destroy();