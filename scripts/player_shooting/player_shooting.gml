function player_shooting(){
    var center_x = x + sprite_width / 2;
    var center_y = y + sprite_height / 2;

    // Face the mouse relative to the player's center
    if (mouse_x > center_x) {
        facing_dir = 1;
    } else if (mouse_x < center_x) {
        facing_dir = -1;
    }

    var shoot_key = keyboard_check_pressed(ord("K")) || mouse_check_button_pressed(mb_left);

    if (shoot_key) {
	    var spawn_x = center_x + facing_dir * (sprite_width / 2 + 4);
	    var bullet = instance_create_layer(spawn_x, center_y, "Visible_Instances", obj_Bullet);

	    // Top-left origin: shift left-facing bullets back by their own width
	    if (facing_dir == -1) {
	        bullet.x -= bullet.sprite_width;
    }

    bullet.speed = 10 * facing_dir;
}
}