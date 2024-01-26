/// @description Reformats any corner variables into top left and bottom right
function _gui_parse_corners(_x1, _y1, _x2, _y2) {
	box = {
		x: min(_x1, _x2),
		y: min(_y1, _y2),
		x2: max(_x1, _x2),
		y2: max(_y1, _y2),
		w: -1,
		h: -1
	}
	
	struct_set(box, "w", box.x2 - box.x);
	struct_set(box, "h", box.y2 - box.y);
	
	return box;
}