// background text generation
background_generator = gpt_create("Background Generator", OpenAI_gpt_3_5_turbo, 256, 1);
var _lines_in_screen = int64(room_height / string_height_scribble("[fnt_source_code_pro_small]text[/]")) + 1;
gpt_messages_add(background_generator, "system", "Generate at least " + string(_lines_in_screen) + " random lines of code with **no comments** that \"looks like\" runnable code. **Do not put in any URLs, passwords, or usernames, reference variables instead.** Make it look like it's code that connects to a database and manages the data. Only generate the code. No markdown code block indicators (no ```).\n\n```");
gpt_prompt_error_retry(background_generator, -1, 5, true, 0, 1);

draw_background = false;
display_loading = false;

background_text = "loading API...";
background_text_received = false;
background_textbox = undefined;
background_typist = scribble_typist();
background_typist.in(0.8, 5);

background_effect = false;
background_effect_countdown = false;

blur_x_distance = 0;