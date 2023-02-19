/// @description Pause alarms and set vw and vh

// Initialize viewport positioning based on alert placement
if (vw == noone || vh == noone) {
	// Centered x and y
	if (alert.placement == "center") {	
		vw = view_xport[0] + view_wport[0] / 2;
		vh = view_yport[0] + view_hport[0] / 2;
	}

	// Centered x top y
	if (alert.placement == "center-top") {
		vw = view_xport[0] + view_wport[0] / 2;
		vh = view_yport[0];
	}
	
	// Centered x bottom y
	if (alert.placement == "center-bottom") {
		vw = view_xport[0] + view_wport[0] / 2;
		vh = view_yport[0] + view_hport[0];
	}
	
	// Bottom x right y
	if (alert.placement == "bottom-right") {
		vw = view_xport[0] + view_wport[0];
		vh = view_yport[0] + view_hport[0];
	}
	
	// Left x bottom y
	if (alert.placement == "left-bottom") {
		vw = view_xport[0];
		vh = view_yport[0] + view_hport[0];
	}

	// Bottom x top y
	if (alert.placement == "bottom-top") {
		vw = view_xport[0] + view_wport[0]
		vh = view_yport[0];
	}
}

if (global.dialog_exists) {
	
	// Get number of alarms for object
	if (number_of_alarms == noone) {
		number_of_alarms = 0;
	
		// Increment number of alarms total if an alarm is set
		for (var i = 0; i < 12; i++) {
			if (alarm_get(i) >= 0) number_of_alarms++;
		}
	}
	
	// Pause all active running alarm timers
	if (!ds_exists(paused_alarms, ds_type_list)) {
		
		// Data list of paused alarm times
		paused_alarms = ds_list_create();
	
		// Pause all alarms and save its value in a data list
		for (var i = 0; i < number_of_alarms; i++) {
		
			// Add alarms current value to list
			ds_list_add(paused_alarms, alarm[i]);
		
			// Stop the alarm
			alarm[i] = -1;
		}
	}
	
} else {
	
	// Unpause all alarms if there any
	if (ds_exists(paused_alarms, ds_type_list)) {
		var paused_alarms_size = ds_list_size(paused_alarms);
		
		// Set alarm timer back to the value it was on before pausing
		for (var i = 0; i < paused_alarms_size; i++) {
			alarm[i] = ds_list_find_value(paused_alarms, i);
		}
		
		// Destroy list of paused alarms
		ds_list_destroy(paused_alarms);
	}
	
}