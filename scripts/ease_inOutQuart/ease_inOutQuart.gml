/// @description Returns the output of "ease in out quart" function with input x (between 0 and 1 - progress of function)
/// https://easings.net/#easeInOutQuarts

function ease_inOutQuart(_x) {
    if (_x < 0.5) {
        return 8 * _x * _x * _x * _x;
    } else {
        return 1 - power(-2 * _x + 2, 4) / 2;
    }
}