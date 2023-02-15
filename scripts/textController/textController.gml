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
function DrawTextOutlined(xx, yy, outline_color, string_color, string, font) {
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
* @param string (string)
*
* @return array
*/
function ExplodeString(string) {
	char_string = 0;
	if string_pos(" ", text) != 0 {
	    var cc = string_count(" ",text);
	    for (i = 0; i <= cc; i += 1) {
	        if (i < cc) {
	            char_string[i] = string_copy(text, 0, string_pos(" ", text)-1 ); // get the piece exploded off
	            text = string_copy(text, string_pos(" ", text)+1, string_length(text) ); // re-write text var to be what remains
	        }
	        else
	            char_string[i] = text;
	    }
	    return char_string;
	}
	else
	    return text
}

function string_wrap(_text, _width)
{
var _text_wrapped = "";
var _space = -1;
var _char_pos = 1;
while (string_length(_text) >= _char_pos)
    {
    if (string_width(string_copy(_text, 1, _char_pos)) > _width)
        {
        if (_space != -1)
            {
            _text_wrapped += string_copy(_text, 1, _space) + "\n";
            _text = string_copy(_text, _space + 1, string_length(_text) - (_space));
            _char_pos = 1;
            _space = -1;
            }
        }
    if (string_char_at(_text,_char_pos) == " ")
        {
        _space = _char_pos;
        }
    _char_pos += 1;
    }
if (string_length(_text) > 0)
    {
    _text_wrapped += _text;
    }
return _text_wrapped;
}