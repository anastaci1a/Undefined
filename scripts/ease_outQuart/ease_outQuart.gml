/// @description Returns the output of "ease out quart" function with input x (between 0 and 1 - progress of function)
/// https://easings.net/#easeOutQuart

function ease_outQuart(_x){
	return 1 - power(1 - _x, 4);
}