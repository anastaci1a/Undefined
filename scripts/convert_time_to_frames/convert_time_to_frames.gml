/// @description Converts current_time to frames (integer), mods with _frame_count (optional)

function convert_time_to_frames(_frame_rate, _frame_count = -1) {
    var _frame = floor((current_time / 1000) * _frame_rate);
	if (_frame_count != -1) _frame = _frame % _frame_count;
	return _frame;
}