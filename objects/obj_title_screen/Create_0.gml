// title text displaying
scribble_font_set_default("fnt_raleway");

wave_size = 100;
wave_size_multiplier = 0.999;
wave_freq = 10;
scribble_anim_wave(wave_size, wave_freq, 0.1);

scribble_color_set(c_black);

title_array = [
	"[wave]Anamorphic Sound[/]",
	"",
	"[fnt_source_code_pro_large][wave][shake][c_lime]UNDEFINED[/]"
];
title_array_index = 0;

titlebox = undefined;
typist = scribble_typist();
typist.in(0, 0);

title_x = room_width / 2;
title_y = room_height / 2;
title_scale = 1;


// background text
background = instance_create_layer(0, 0, "Background_Text", obj_title_screen_background);


// menu
menu = {
	start: false,
	padding: 80,
	title: {
		ease: 0,
		scale: 0.85,
		pos: undefined,
	},
	
	// options gui
	options: {
		start: false,
		pos: undefined,
		textbox: undefined,
		text: "",
		state: [],
		new_menu: true,
		count: 0,
		typist: scribble_typist(),
		
		gui: {
			display_text: "root/",
			type: "inner",
			inner: [
				{
					display_text: "new_game/",
					type: "inner",
					inner: [
						{
							display_text: "...",
							type: "upper"
						},
						{
							display_text: ".README",
							type: "read box",
							contents: "This game is yours to discover. It's not mine, it never was. It was always created with you, the player, in mind. This is your opportunity to have an experience that has never been truly possible in a vehicle such as this, and now, this world is your oyster.\n\n~A"
						},
						{
							display_text: "context.params",
							type: "parameter box",
							parameters: [
								"Setting/World Genre: Fantasy, Sci-Fi, Post-Apocalyptic, Historical, Superhero, Cyberpunk, etc.",
								"Worldbuilding: A general idea of the overall world the story takes place in.",
								"Primary Conflict(s): The main source of tension or conflict.",
								"Protagonist (Player): A description of the main character that you will be playing as.",
								"Main Quest Objective(s): A broad overview of the main quest(s) or end goal(s) that you the protagonist will work towards."
							],
							editables: [
								"Space Roguelike",
								"The year is 2306, and much of human life has fled the \"Sol System\", the birthplace of humanity. Humanity is now a wandering species, exploring different systems throughout the galaxy. One of which is the Kepler system, containing Kepler-22b. Humans in the 2200s went on a thousand year journey to this system, traveling at half the speed of light in several vessels - known as the Lazarus missions. [...]",
								"[...]",
								"Yvonne is a rogue pilot stole a ship from a Starlight development facility, and scavenges/repairs tech at abandoned outposts and stations, either to sell or to use for her own purposes. The nature of her work puts her in the crossfire of conflict often.",
								"[...]"
								//"[...]", "[...]", "[...]", "[...]", "[...]"
							]
						},
						{
							display_text: "optional_context.txt",
							type: "input box",
							contents: "### Enter more details about your world here"
						},
						{
							display_text: "start_game.run",
							type: "start game"
						}
					]
				},
				{
					display_text: "saves/",
					type: "inner",
					inner: [
						{
							display_text: "...",
							type: "upper"
						}
					]
				},
				{
					display_text: "settings.params",
					type: "parameter box",
					parameters: [
						"parameter 1: hyhtrgefw",
						"parameter 2: thtrgefwdvs"
					],
					editables: ["[...]", "[...]"]
				},
				{
					display_text: "exit/",
					type: "inner",
					inner: [
						{
							display_text: "...",
							type: "upper"
						},
						{
							display_text: "credits.txt",
							type: "read box",
							contents: "Made with love.\n\n~A"
						},
						{
							display_text: "exit.run",
							type: "function",
							func: function() {
								game_end();
							}
						}
					]
				}
			]
		},
		
		// selection cursor
		selection: {
			display: false,
			textbox: undefined,
			text: "",
			select: function(_selection, _cursor = "$") {
				var _text = "[fnt_source_code_pro_mediocre][c_white]\n";
				for (var _i = 0; _i < _selection; _i++) _text += "\n";
				_text += _cursor + "[/]";
				return _text;
			}
		}
	}
}

variable_struct_set(menu.title, "pos", {
	x: menu.padding + string_width_scribble("[scale," + string(menu.title.scale) + "]" + title_array[2] + "[/]")/2,
	y: room_height/2
});

variable_struct_set(menu.options, "pos", {
	x: menu.padding,
	y: menu.title.pos.y + menu.padding/2 + string_height_scribble("[scale," + string(menu.title.scale) + "]" + title_array[2] + "[/]")/2
});

menu.options.typist.in(1, 0);


// boxes
box = {
	using: false,
	using_type: "",
	using_index: "",
	
	enter_ease: 0,
	save_ease: 0,
	exit_ease: 0,
	arrow_left_vis: -0.5,
	arrow_right_vis: 0,
	
	saving_exit: false,
	
	parameters_index: 0,
	parameters: [],
	editables: [],
	contents: "",
	
	filename_box: undefined,
	parameter_box: undefined,
	box: undefined,
	
	width: room_width/2,
	height: 0,
	
	background: {
		sprite_top: spr_title_screen_box_background_top,
		sprite: spr_title_screen_box_background,
		sprite_frame: 0,
		scale: 7.11,
		x: room_width,
		y: room_height,
		visibility: 0,
		animate: 0
	}
}


// new/saved game
start_effect = false;
start_effect_blur_x_distance = 0;

game_start_room = undefined;
room_new_game = rm_1_character_customization;
room_saved = rm__template;