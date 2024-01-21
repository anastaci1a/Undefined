function scr_text_insert_font_changes(input_text) {
	var _return_text = "[0]";
	for (var _i = 1; _i <= string_length(input_text); _i++) {
		var _index = string_char_at(input_text, _i);
		_return_text += _index + "[/font]"
		if (_i != string_length(input_text)) _return_text += "[" + string(_i + 0) + "]";
	}
	return _return_text;
}