/// @description Creates a box object (and returns ID)

function gui_box_create() {
	return instance_create_layer(0, 0, layer, gui_box);
}