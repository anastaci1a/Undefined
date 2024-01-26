/// @description Creates a DALL·E image generator (returns ID)

function dalle_create(_dalle_name) {
	var _dalle = instance_create_layer(0, 0, layer, dalle_dalle);
	with (_dalle) {
		dalle_name = _dalle_name;
	}
	return _dalle;
}