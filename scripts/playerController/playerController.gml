function Player() constructor {
	// Player states and controls
	controls = ["W", "A", "S", "D"];
	walkingSpeed = 2; // walking
	runningSpeed = 3; // running
	walkingImageSpeed = 0.2;
	runningImageSpeed = 0.3;
	frames = {
		W: [12, 13, 14, 15],
		A: [4, 5, 6, 7],
		S: [0, 1, 2, 3],
		D: [8, 9, 10, 11],
	};
	
	keys = []; // Current keys being pressed
	sprites = frames.S;
}
