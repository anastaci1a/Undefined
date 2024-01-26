/// @description Floors input to nearest odd number

function ceil_even(_n) {
	return int64(_n) + (int64(_n) % 2 != 0);
}