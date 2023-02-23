/**
* Draws text with an outline
*
* @param xx (int)
* @param yy (int)
* @param outline_color (int)
* @param string_color (int)
* @param string (string)
* @param font (int)
*
* @return void
*/
function drawTextOutlined(xx, yy, outline_color, string_color, string, font) {
	draw_set_font(font);
	
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

/**
* Explodes string by spaces
*
* @param text (string)
*
* @return array
*/
function explodeString(text) {
	var char_string = 0;
	
	if (string_pos(" ", text) == 0) {
		return text
	}
	
	var cc = string_count(" ",text);
		
	for (var i = 0; i <= cc; i += 1) {
	    if (i < cc) {
	        char_string[i] = string_copy(text, 0, string_pos(" ", text)-1 );
	        text = string_copy(text, string_pos(" ", text)+1, string_length(text) );
	    } else {
	        char_string[i] = text;
		}
	}
		
	return char_string;
}

/**
* Generate random guid
*
* @return string
*/
function generateGuid() {
	var guid = "";
	
	for (var i = 0; i < 32; i++) {
	    if (i == 8 || i == 12 || i == 16 || i == 20) guid += "-";
	    guid += choose("0", "1", "2", "3", "4", "5", "6", "7",
	        "8", "9", "A", "B", "C", "D", "E", "F");
	}
	
	return guid;
}

/**
* Text wrap a given string by a desired width
*
* @return string
*/
function string_wrap(text, width) {
	var text_wrapped = "";
	var space = -1;
	var char_pos = 1;
	
	while (string_length(text) >= char_pos) {
		if (string_width(string_copy(text, 1, char_pos)) > width) {
	        if (space != -1) {
	            text_wrapped += string_copy(text, 1, space) + "\n";
	            text = string_copy(text, space + 1, string_length(text) - (space));
	            char_pos = 1;
	            space = -1;
	        }
		}
		
	    if (string_char_at(text,char_pos) == " ") {
	        space = char_pos;
		}
		
		char_pos += 1;
    }
	
	if (string_length(text) > 0) {
	    text_wrapped += text;
	}
	
	return text_wrapped;
}