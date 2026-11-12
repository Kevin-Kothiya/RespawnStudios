function player_shooting(){
    // True center of the player, regardless of sprite origin
    var center_x = (bbox_left + bbox_right) / 2;
    var center_y = (bbox_top + bbox_bottom) / 2;
    var half_w = (bbox_right - bbox_left) / 2;
    var half_h = (bbox_bottom - bbox_top) / 2;

    // Full 360-degree aim toward the mouse
    var aim_dir = point_direction(center_x, center_y, mouse_x, mouse_y);

    // Flip the player left/right only
    if (mouse_x > center_x) facing_dir = 1;
    else if (mouse_x < center_x) facing_dir = -1;

    var shoot_key = keyboard_check_pressed(ord("K")) || mouse_check_button_pressed(mb_left);

    if (shoot_key) {
        var dx = lengthdir_x(1, aim_dir);
        var dy = lengthdir_y(1, aim_dir);

        // Distance from center to the edge of the player's box along the aim direction
        var dist_x = (abs(dx) > 0.0001) ? half_w / abs(dx) : 99999;
        var dist_y = (abs(dy) > 0.0001) ? half_h / abs(dy) : 99999;

        // Bullet length without needing an existing instance
        var bullet_w = sprite_get_width(object_get_sprite(obj_Bullet));
        var spawn_dist = min(dist_x, dist_y) + (bullet_w / 2) + 4;

        var spawn_x = center_x + dx * spawn_dist;
        var spawn_y = center_y + dy * spawn_dist;

        var bullet = instance_create_layer(spawn_x, spawn_y, "Visible_Instances", obj_Bullet);
        bullet.direction   = aim_dir;
        bullet.image_angle = aim_dir;
        bullet.speed       = 10;
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