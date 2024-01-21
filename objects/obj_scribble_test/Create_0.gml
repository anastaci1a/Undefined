scribble_font_set_default("fnt_tiny");

fonts = [
	"fnt_assys",
	"fnt_bitpap",
	"fnt_fatpixel",
	"fnt_game_over",
	"fnt_hardpixel",
	"fnt_null_pointer",
	"fnt_pixy",
	"fnt_televideo",
	"fnt_tiny",
	"fnt_wc_aquablues_bta"
];

current_font = 8;
next_font = 0;
next_font_index = 0;
font_iterator = 0;

text_array = [
	"Testing testing 1 2 3...",
	"Testing AGAIN 1 2 3...",
	"FIIINE I'm done"
];
text_array_index = 0;
display_text = "";

textbox = undefined;
typist = scribble_typist();
typist.in(0.07, 0);