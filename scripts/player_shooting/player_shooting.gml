function player_shooting(){
	// Bullet direction and shooting

	// Update facing direction based on movement
	if (x < mouse_x) facing_dir = 1;
	if (x > mouse_x) facing_dir = -1;

	// Shooting logic (K key or Right Click)
	var shoot_key = keyboard_check_pressed(ord("K")) || mouse_check_button_pressed(mb_left);

	if (shoot_key) {
	    // Create bullet slightly offset from player center
	    var bullet = instance_create_layer(x + (facing_dir * 12), y, "Instances", obj_Bullet);
    
	    // Pass speed and direction to bullet
	    bullet.speed = 10 * facing_dir;
	}
}