/// @description Prompts DALL·E to generate image.
/// @return undefined

function dalle_generate(_id_of_instance, _prompt, _style, _size, _model = "dall-e-3") {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			prompt = _prompt;
			style = _style; // style - vivid or natural
			size = _size;   // size  - dall-e-2: 256x256, 512x512, 1024x1024
			                //         dall-e-3: 1024x1024, 1792x1024, 1024x1792
			model = _model; // model - dall-e-2 or dall-e-3 (defaults to dall-e-3)
			event_user(0);
		}
	} else {
		show_debug_message("ERROR [In dalle_generate - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}