var item = global.inventory[| slot_pos];
//show_message(string(item));

if (item) {
	// Get players current direction
	with (obj_player) {
		show_message(image_index);
	}
	
	instance_create_layer(obj_player.x, obj_player.y, "Instances", item.object);
}