// Skip dialog
var length = string_length(test[text_current]);
if (char_current < length) {
    char_current = length;
} else {
    text_current += 1;
    if (text_current > text_last){
        room_restart();
	} else {
        test[text_current] = string_wrap(test[text_current], text_width);
        char_current = 0;
	}
}
