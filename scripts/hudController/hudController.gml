// Return day in string format
function getDayString() {
	var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
	return days[global.day];
}

// Return formatted time in hours or minutes
function formatTime(time) {
	if (time < 10) {
		return "0" + string(time);
	} else {
		return string(time);
	}
}

// Update hour when 60 minutes have passed
function updateHour() {
	// Reset minutes
	global.minutes = 0;
	
	// Increase hour
	global.hours ++;
}

// Update hour when 60 minutes have passed
function updateDay() {
	// Reset hours
	global.hours = 0;
	
	// Reset day to Monday if it is currently Sunday
	if (global.day == 6) {
		global.day = 0;
	} else {
		// Otherwise, increase the day
		global.day ++;
	}
	
	// Increase total days
	global.total_days ++;
}
