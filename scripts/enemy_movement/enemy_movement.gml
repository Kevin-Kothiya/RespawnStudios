function enemy_ai(){
    player_pos_x = obj_Player.x;
    player_pos_y = obj_Player.y;
    
    enemy_h_speed = enemy_move_speed;
    
    // Tracks the player's horizontal movement
    if (player_pos_x < x) {
        flip_signs("-");
    } else if (player_pos_x > x){
        flip_signs("+");
    }
	
	// to jump over walls
	if (place_meeting(x + sign(enemy_h_speed), y, obj_Platform) && place_meeting(x, y + 1, obj_Platform)) {
		enemy_jump();
	}
}

function flip_signs(sign_value){
    // flip to positive
    if (enemy_h_speed < 0 && sign_value == "+"){
        enemy_h_speed *= -1;
    } 
    // flip to negative
    else if (enemy_h_speed > 0 && sign_value == "-"){
        enemy_h_speed *= -1;
    }
}


function enemy_jump(){
    enemy_v_speed = enemy_jump_force;
}

