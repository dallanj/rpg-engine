function Alert () constructor {
	guid = GenerateGuid();
	type = "";
	size = "small"; // medium
	placement = "left-bottom"; // center-bottom,center-top,center,bottom-right,left-bottom,bottom-top
	title = "";
	description = "";
	time = 4; // Seconds
	created_at = current_second; // current timestamp seconds,
	expires_in = created_at + 5; // 15 seconds
}
