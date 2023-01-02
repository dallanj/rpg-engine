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