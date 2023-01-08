/// @description Insert description here
// You can write your code in this editor

var _size = ds_map_size(save_data);

for (var i = 0; i < _size; i ++) {
	//var _item = save_data[| i];
	
	var _x = 500;
	var _y = 10 + 30 * i;
	
	draw_text(_x, _y, string(ds_map_find_value(save_data, i)));
}

draw_set_color(c_white);
draw_text(10,400, json_encode(save_data));


//show_debug_message(json_encode(save_data));