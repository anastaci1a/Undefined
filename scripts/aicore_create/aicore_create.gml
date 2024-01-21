/// @description Creates and initializes an obj_aicore object, setting global.aicore to its id

function aicore_create() {
	var _id = instance_create_layer(0, 0, layer, obj_aicore);
	global.aicore = _id;
}