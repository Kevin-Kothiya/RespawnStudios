global.next = false;
global.move_to_projectiles = false;
global.special_mechanic = false;
global.done = false;
global.pressed_w = false;
global.pressed_a = false;
global.pressed_d = false;
global.clicked_mouse = false;
global.pressed_g = false;
global.line = 0;
global.timer = 5 * game_get_speed(gamespeed_fps);


function Show_Controls(){
	if (obj_Player.tutorial == false){

		if (global.move_to_projectiles == false){
			WASD_Controls();
		}
		else if (global.move_to_projectiles && global.special_mechanic == false){
			Projectile_Controls()
		}
		else if (global.special_mechanic && global.done == false){
			Special_Mechanic_Controls();
		}
		else {
			obj_Player.tutorial = true;
		}
	}
}

function WASD_Controls(){
	// Welcoming the player
	if (global.next == false){
		Write_Text(100, 300, "Welcome to the Tutorial Level!");
		if (global.timer > 0){
			global.timer--;
		}
		if (global.timer <= 0){
			global.next = true;
			global.timer = 5 * game_get_speed(gamespeed_fps);
		}
	}
	// Telling the player to press w to jump
	else if (global.pressed_w == false){
		Write_Text(100, 300, "Press W to Jump");
		var check_key = keyboard_check_pressed(ord("W"));
		if (check_key){
			global.pressed_w = true;
		}
	}
	// Telling the player to press a to move left
	else if (global.pressed_a == false){
		Write_Text(100, 300, "Press A to move Left");
		var check_key = keyboard_check_pressed(ord("A"));
		if (check_key){
			global.pressed_a = true;
		}
	}
	// Telling the player to press d to move right
	else if (global.pressed_d == false){
		Write_Text(100, 300, "Press D to move Right");
		var check_key = keyboard_check_pressed(ord("D"));
		if (check_key){
			global.pressed_d = true;
		}
	}
	else if (global.pressed_d == true) {
		global.move_to_projectiles = true;
	}

}

function Projectile_Controls(){
	// Telling the player to left on their mouse to shoot
	if (global.clicked_mouse == false){
		Write_Text(100, 300, "Left Click on the mouse anywhere in the Room Screen to Shoot Bullets!");
		var check_click = mouse_check_button_pressed(mb_left);
		if (check_click){
			global.clicked_mouse = true;
		}
	}

	else if (global.pressed_g == false){
		var long_text = @"Press G to throw a Grenade at a Short Distance!
Hold G to throw the Grenade at a Further Distance

If the Mouse is to the Right Side of the Player, Grenade is thrown Right

If the Mouse is to the Left Side of the Player, Grenade is thrown Left
";
		Write_Text(100, 100, long_text);
		var check_key = keyboard_check_pressed(ord("G"));
		if (check_key){
			global.pressed_g = true;
		}
	}
	else if (global.pressed_g){
		global.special_mechanic = true;
	}
}

function Special_Mechanic_Controls(){
	if (global.line == 0){
		Write_Text(100, 100, "Now we will learn how to wall Jump");
		Count_Down_Timer();
	} else if (global.line == 1){
		Write_Text(100, 100, "First you need to get closer to the wall on your Left");
		Count_Down_Timer();
	} else if (global.line == 2){
		Write_Text(100, 100, "Then Press A and W at the Same Time");
		Count_Down_Timer();
	} else if (global.line == 3){
		Write_Text(100, 100, "If it worked then Congratulations, you have Finished the Tutorial!");
		Count_Down_Timer();
	} else if (global.line == 4){
		Write_Text(100, 100, "Move all the way to the Right Side to Exit the Tutorial Level");
		Count_Down_Timer();
	} else {
		global.done = true;
	}

}

function Count_Down_Timer(){
	if (global.timer > 0){
		global.timer--;
	} else if (global.timer <= 0){
		global.line ++;
		Reset_Timer();
	}
}

function Reset_Timer(){
	if (global.timer <= 0){
		global.timer = 5 * game_get_speed(gamespeed_fps);
	}
}

function Write_Text(_x, _y, _text){
	// String dimensions
	var pad = 16;
	draw_set_font(fnt_menu);
	var h = string_height(_text);
	var w = string_width(_text);

	// background
	draw_set_color(c_gray);
	draw_roundrect(_x - pad, _y - pad, _x + w + pad, _y + h + pad, false);

	// For text
	draw_set_font(fnt_menu);
	draw_set_color(c_white);
	draw_text(_x, _y, _text);
}
