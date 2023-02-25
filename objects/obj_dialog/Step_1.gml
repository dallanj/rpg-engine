/// @description

// If at the end of a dialog script
if (text_current <= text_last) {
	// Run dialog scripts if there are any
	if (data[text_current].before != noone) {		
		before_scripts = runDialogScript(data[text_current].before);
		
		// Generic scripts consist of dialog stating the player can't start a quest or has unclaimed rewards
		if (is_struct(before_scripts)) {
			switchDialog(before_scripts);
		}
	} else {
		before_scripts = true;
	}
}


