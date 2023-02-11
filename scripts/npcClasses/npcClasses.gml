function Npc () constructor {
	name = "";
	walkingSpeed = 2; // walking
	runningSpeed = 3; // running
	walkingImageSpeed = 0.2;
	runningImageSpeed = 0.3;
	sprite = "";
	object = "";
	description = "";
	dialog_script[0] = "";
	frames = {
		W: [0, 1, 2],
		D: [3, 4, 5],
		S: [6, 7, 8],
		A: [9, 10, 11]
	};
}
