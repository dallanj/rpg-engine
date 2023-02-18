/// @description

// If at the end of a dialog script
if (text_current <= text_last) {
	// Run dialog scripts if there are any
	if (data[text_current][3] != noone) {
		runDialogScript(data[text_current][3]);
	}
}


