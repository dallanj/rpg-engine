// Player movements
var playerSpeed = 3;
image_speed = 0;

// Left movement
if keyboard_check(ord("A")) {
	if (!place_meeting(x - playerSpeed, y, obj_wall)) {
		x -= playerSpeed;
		image_index = 2;
		image_xscale = 1;
	} else {
		// Move 1 pixel until player is next to wall
        while (!place_meeting(x - 1, y, obj_wall)) {
            x--;
        }
	}
}

// Right movement
if keyboard_check(ord("D")) {
	if (!place_meeting(x + playerSpeed, y, obj_wall)) {
		x += playerSpeed;
		image_index = 2;
		image_xscale = -1;
	} else {
		// Move 1 pixel until player is next to wall
        while (!place_meeting(x + 1, y, obj_wall)) {
            x++;
        }
	}
}

// Up movement
if keyboard_check(ord("W")) {
	if (!place_meeting(x, y - playerSpeed, obj_wall)) {
		y -= playerSpeed;
		image_index = 0;
	} else {
		// Move 1 pixel until player is next to wall
        while (!place_meeting(x, y - 1, obj_wall)) {
            y--;
        }
	}
}

// Down movement
if keyboard_check(ord("S")) {
	if (!place_meeting(x, y + playerSpeed, obj_wall)) {
		y += playerSpeed;
		image_index = 1;
	} else {
		// Move 1 pixel until player is next to wall
        while (!place_meeting(x, y + 1, obj_wall)) {
            y++;
        }
	}
}