// Draw text with an outline
function DrawTextOutlined(xx, yy, outline_color, string_color, string) {
	// Outline
	draw_set_color(outline_color);
	draw_text(xx+1, yy+1, string);
	draw_text(xx-1, yy-1, string);
	draw_text(xx, yy+1, string);
	draw_text(xx+1, yy, string);
	draw_text(xx, yy-1, string);
	draw_text(xx-1, yy, string);
	draw_text(xx-1, yy+1, string);
	draw_text(xx+1, yy-1, string);
		
	// Text
	draw_set_color(string_color);
	draw_text(xx, yy, string);
}

player = {
    north: {
		key: keyboard_check(ord("W")),
		indexes: [12, 13, 14, 15]
	},
    east: {
		key: keyboard_check(ord("A")),
		indexes: [8, 9, 10, 11]
	},
	south: {
		key: keyboard_check(ord("S")),
		indexes: [0, 1, 2, 3]
	},
	west: {
		key: keyboard_check(ord("D")),
		indexes: [4, 5, 6, 7]
	}
};