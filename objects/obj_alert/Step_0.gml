// Increase alpha by alpha_timer each frame
if (!global.dialog_exists) {
	
	// Fade in effect for the alert
	if (alert_active && (alpha < max_alph)) {
		alpha += effect_timer;
		
		if (alert.placement == "center-top") {
			shifting -= effect_timer;
		} else {
			shifting += effect_timer;
		}
	}
	
}

// Fade out effect for the alert
if (!alert_active) {
	alpha -= effect_timer;
	
	//
	if (alert.placement == "center-top") {
		shifting += effect_timer;
	} else {
		shifting -= effect_timer;
	}
		
	// Delete once faded out
	if (alpha <= 0) {
		destroyAlert(alert);
	}
}
