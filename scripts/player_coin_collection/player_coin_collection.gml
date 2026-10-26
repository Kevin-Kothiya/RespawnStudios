function player_coin_collection(){
	if place_meeting(x, y, obj_Gears){
		player_gears ++;
		show_debug_message(string(player_gears));
	}
}