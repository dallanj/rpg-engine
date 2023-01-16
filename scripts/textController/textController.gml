/**
* Draws text with an outline
*
* @param xx (int)
* @param yy (int)
* @param outline_color (int)
* @param string_color (int)
* @param string (string)
*
* @return void
*/
function DrawTextOutlined(xx, yy, outline_color, string_color, string) {
	draw_set_font(font_inventory);
	
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
	
	return;
}