instance_destroy();

// Does some damage to the player
if (obj_Player.player_health > 0){
	obj_Player.player_health -= bullet_damage;
}
