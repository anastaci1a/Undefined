// user input
if (keyboard_check_pressed(vk_space) && scribble_is_text_element(textbox)) {
	if (typist.get_paused()) {
		typist.unpause();
	} else if (typist.get_state() >= 1) {
		if (textbox.get_page() < textbox.get_page_count() - 1) {
			textbox.page(textbox.get_page() + 1);
		} else if (title_array_index != array_length(text_array) - 1) {
			text_array_index++;
			next_font_index = 0;
		} else {
			// do something
		}
	} else {
		typist.skip();
	}
}

// font inserter
display_text = title_array[title_array_index];
var _text_length = string_length(display_text);
display_text = scr_text_insert_font_changes(display_text);
for (var _i = 0; _i < _text_length; _i++) {
	var _font_index = 0;
	if (_i >= next_font_index) _font_index = current_font;
	else _font_index = next_font;
	var _font = fonts[_font_index];
	
	display_text = string_replace_all(display_text, "[" + string(_i) + "]", "[" + _font + "]");
}

// font iterator
var _buffer = 0;
var _iteration_delta_time = 1;
font_iterator--;
if (font_iterator <= 0) {
	if (next_font_index > _text_length + _buffer) {
		current_font = next_font;
		while (next_font == current_font) {
			next_font = int64(random_range(0, array_length(fonts)));
		}
		next_font_index = 0;
	}
	next_font_index++;
	font_iterator = _iteration_delta_time;
}