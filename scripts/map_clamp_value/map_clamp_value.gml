/// @description Maps and clamps value from between two bounds to two new bounds.

function map_clamp_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound) {
	var _r = map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound);
	_r = clamp(_r, _desired_lowered_bound, _desired_upper_bound);
	return _r;
}