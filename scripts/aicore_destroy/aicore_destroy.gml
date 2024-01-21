/// @description Destroys aicore object and resets global.aicore

function aicore_destroy() {
	instance_destroy(global.aicore);
	global.aicore = undefined;
}