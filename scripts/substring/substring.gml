/// @description selects part of string
/// @returns String

function substring(__string, _start, _end) {
	var _start_str = "[[start]]"; _start = int64(_start) + 1;
	var _end_str = "[[end]]"; _end = int64(_end) + 1;
	var _string = string_split(string_insert(_start_str, variable_clone(__string), _start), _start_str)[1];
	_string = string_split(string_insert(_end_str, _string, _end), _end_str)[0];
	return _string;
}