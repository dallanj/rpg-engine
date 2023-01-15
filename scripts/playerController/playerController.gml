function Player() constructor {
	// Player states and controls
	controls = ["W", "A", "S", "D"];
	Speed = 3;
	Fps = 0.3;
	frames = {
		W: [12, 13, 14, 15],
		A: [4, 5, 6, 7],
		S: [0, 1, 2, 3],
		D: [8, 9, 10, 11],
	};
	
	// Current state of player
	state = {
		sprites: frames.S,
		Speed: Speed,
		Fps: 0,
		keys: [] // Current keys being pressed
	};
}
