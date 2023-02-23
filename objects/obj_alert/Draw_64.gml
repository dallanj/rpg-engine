// Draw alert messages

if ((global.alerts_top || global.alerts_bottom) && !global.dialog_exists) {
	
	// Get position of alert in the alerts list
	var index;
	
	var item_exists = alert.item != noone;
	
	if (alert.placement == "center-top") {
		index = ds_list_find_index(global.alerts_top,alert);
	} else {
		index = ds_list_find_index(global.alerts_bottom,alert);
	}
	
	if (index < 0) {
		// Remove alert from alerts list and destroy object instance
		destroyAlert(alert);	
	}
	
	// Multiply w/h to change the position of where the alert is shown
	var position = index + 1;
	
	// For y axis bottom alerts
	var calc_y_axis = -1;
		
	// Text width and heights
	draw_set_font(alert_font);
	text_height = string_height(alert.title);
	text_width = string_width(alert.title);
	
	// Small sized alerts TODO: EASIER SYSTEM TO CHOSE MEDIUM OR SMALL, AND DIRECTION OF ALERT
	if (alert.size == "small") {
		if (alert.placement == "left-bottom") {
			// Bottom y left x
			alert_x_pos = vw + text_height / 2;
			alert_y_pos = vh - text_height / 2;
		}
	}
	
	// Medium sized alerts
	if (alert.size == "medium") {
		if (alert.placement == "center-top") {
			// Centered x top y
			alert_x_pos = vw - text_width;
			alert_y_pos = vh - text_height * 1.5;
			calc_y_axis = 1;
		}
		
		if (alert.placement == "center-bottom") {
			// Centered x bottom y
			alert_x_pos = vw - text_width;
			alert_y_pos = vh - text_height * 2;
		}
	}

	// Hovering effect
	alert_y_pos = alert_y_pos + sin(hover_timer * 0.1) * 1.8;
	hover_timer++;

	// Shifting effect
	shift_effect = shifting * 50;
	
	// Calculate additional starting height for alert based on position in the list
	var alert_height_pos, item_height, item_width, item;
	
	// Medium sized alerts
	if (alert.size == "medium") {
		alert_width = text_width * 2;
		alert_height = text_height * 2;
		padding_top = font_sep / 2;
		
		// Center align text
		text_y_center = alert_y_pos + text_height / 2;
		text_x_center = alert_x_pos + text_width / 2;
		alert_height_pos = (alert_height + font_sep) * (position - 1) * -1;
	}

	// Small sized alerts
	if (alert.size == "small") {
		// Center align text
		text_y_center = alert_y_pos + text_height / 3.25;
		text_x_center = alert_x_pos + text_width / 7.5;
		
		// Item sprites
		if (item_exists) {
			item = alert.item;
			item_width = sprite_get_width(item.sprite) * 2;
			item_height = sprite_get_height(item.sprite) * 2.5;
			item_y_center = alert_y_pos + item_height;
			item_x_center = alert_x_pos + item_width;
			gap_between = 20;
			
			//text_x_center = text_x_center + item_width;
			text_x_center = (alert_x_pos + item_width * 1.25) + gap_between;
		}
		
		alert_width = item_exists ? ((text_width + item_width) * 1.25) + gap_between : text_width * 1.25;
		alert_height = text_height * 1.5;
		padding_top = font_sep / 2;
		
		alert_height_pos = (alert_height + font_sep) * (position - 1);
	}
	
	// Draw alert container with effects
	draw_sprite_stretched_ext(
		spr_alert_box_1,
		0,
		alert_x_pos,
		alert_y_pos - (shift_effect) - alert_height_pos,
		alert_width,
		alert_height + padding_top,
		-1,
		alpha
	);
	
	// Draw centered alert message
	draw_text_ext_color(
		text_x_center,
		text_y_center - (shift_effect) - alert_height_pos,
		alert.title,
		text_height + font_sep,
		text_width,
		font_color,font_color,font_color,font_color,
		alpha
	);
	
	if (item_exists) {
		draw_sprite_ext(
			item.sprite,
			0,
			item_x_center,
			item_y_center - (shift_effect) - alert_height_pos,
			2,
			2,
			0,
			-1,
			alpha
		);
	}
}
