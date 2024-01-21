/// @description [Initialize]

// general vars
agent_name = "";
request_id = 0;
latest_response = "";
prompted = false;
message_received_ = false;
message_received = false;
wait_time = 0;
finish_reason = "";
future_prompts = [
	//{
	//	response_format: "example",
	//	msg: {
	//		role: "example",
	//		content: "example
	//	}
	//}
];


// request vars
model = OpenAI_gpt_4_128k;
context = []; // [ { role: "system", content: "You are ChatGPT, a large language model trained by OpenAI.\nCarefully heed the user's instructions.\nRespond using Markdown."} ];
max_tokens = 4096;
temperature = 1;
response_format = "text"; // "text" or "json_object"
stream = true;


// retry if error vars
error = 0; // 0: no error
           // 1: timed out
		   // 2: no response (I think, sorta uncertain on this one)

error_request_delay = false;

error_retry = false;
error_retry_failed = false;
error_retry_times = 0;
error_retry_max_times = 100;
error_retry_countdown = false;
error_retry_countdown_reset_ini = 30;
error_retry_countdown_reset = error_retry_countdown_reset_ini;
error_retry_countdown_reset_multiplier = 1.5;
error_retry_countdown_count = 0;