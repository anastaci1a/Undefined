/// @description Floors input to nearest odd number

function floor_odd(_n) {
	return int64(_n) - (int64(_n) % 2 == 0);
}