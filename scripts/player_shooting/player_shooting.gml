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

function player_grenade(){
    // Charge while G is held
    if (keyboard_check(ord("G"))) {
        grenade_charge = min(grenade_charge + 1, grenade_charge_max);
    }

    // Throw on release
    if (keyboard_check_released(ord("G"))) {
        var center_x = x + sprite_width / 2;
        var dir      = (mouse_x >= center_x) ? 1 : -1;
        var gren_power    = grenade_charge / grenade_charge_max;   // 0 to 1

        var spawn_x = center_x + dir * (sprite_width / 2 + 10);
        var spawn_y = y + sprite_height * 0.25;               // roughly shoulder height

        var g = instance_create_layer(spawn_x, spawn_y, "Visible_Instances", obj_Grenade);
        g.h_speed = dir * lerp(grenade_min_speed, grenade_max_speed, gren_power);
        g.v_speed = lerp(-8, -14, gren_power);                     // upward toss, stronger when charged

        grenade_charge = 0;
    }
}