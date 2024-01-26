/// @description Creates a GPT agent (returns ID)

function gpt_create(_agent_name, _model = OpenAI_gpt_4_128k, _max_tokens = 4096, _temperature = 1) {
	var _agent = instance_create_layer(0, 0, layer, gpt_agent);
	with (_agent) {
		agent_name = _agent_name;
		if (_model != -1) model = _model;
		if (_max_tokens != -1) max_tokens = _max_tokens;
		if (_temperature != -1) temperature = _temperature;
	}
	return _agent;
}