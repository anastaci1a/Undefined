/// @description Returns the output of "ease in out elastic" function with input x (between 0 and 1 - progress of function)
/// https://easings.net/#easeInOutElastic

function ease_inOutElastic(_x) {
	var c5 = (2 * pi) / 4.5;
	if (_x == 0) {
		return 0;
	} else if (_x == 1) {
		return 1;
	} else if (_x < 0.5) {
		return -(power(2, 20 * _x - 10) * sin((20 * _x - 11.125) * c5)) / 2;
	} else {
		return (power(2, -20 * _x + 10) * sin((20 * _x - 11.125) * c5)) / 2 + 1;
	}
}
