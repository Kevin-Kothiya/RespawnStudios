function player_damage(){
	// checking if the player and the enemy have collided
	var enemy_hit = place_meeting(x + 1, y + 1, obj_Enemy);
	if (enemy_hit && alarm[0] < 1 && player_health > 0) {
		player_health -= obj_Enemy.enemy_damange;
		alarm[0] = 60;
	}

}