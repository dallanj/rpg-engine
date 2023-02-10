/// @description Insert description here
// You can write your code in this editor

if (distance_to_object(obj_npc_boundary)) {
	if (floor(random(300)) == 0) {
		npc_direction = floor(random_range(1,3));
		ai_speed = 1;
	}
	
	if (floor(random(300)) == 0) {
		npc_direction = floor(random_range(1,3));
		ai_speed = -1;
	}
}

if (distance_to_object(obj_npc_boundary) >= 100) {
	if (obj_npc_boundary.x < x) {
		npc_direction = floor(random_range(1,2));
		ai_speed = 1;
	}
	
	if (obj_npc_boundary.x > x) {
		npc_direction = floor(random_range(1,2));
		ai_speed = -1;
	}
}

//if (ai_speed == 1 || ai_speed == -1) {
//	if (floor(random(100)) == 0) {
//		npc_direction = floor(random_range(1,2));
//		ai_speed = 0;
//	}
//}

switch (npc_direction) {
	case 1:
		characterMovement(sign(ai_speed * -1), ai_speed * -1, obj_wall);
	break;
	case 2:
		characterMovement(sign(ai_speed * -1), ai_speed * -1, obj_wall, true);
	break;
	default:
		// vertical and horizontal
		characterMovement(sign(ai_speed * -1), ai_speed * -1, obj_wall);
		characterMovement(sign(ai_speed * -1), ai_speed * -1, obj_wall, true);
	break;
}

// Inherit the parent event
event_inherited();

