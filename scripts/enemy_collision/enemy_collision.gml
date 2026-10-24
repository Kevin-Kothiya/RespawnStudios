function enemy_movement(){
    // HORIZONTAL COLLISION
    if (place_meeting(x + enemy_h_speed, y, obj_Platform)) {
        while (!place_meeting(x + sign(enemy_h_speed), y, obj_Platform)) {
            x += sign(enemy_h_speed);
        }
        enemy_h_speed = 0;
    }
    x += enemy_h_speed;

    // VERTICAL COLLISION
    if (place_meeting(x, y + enemy_v_speed, obj_Platform)) {
        while (!place_meeting(x, y + sign(enemy_v_speed), obj_Platform)) {
            y += sign(enemy_v_speed);
        }
        enemy_v_speed = 0;
    }
    y += enemy_v_speed;
}

function enemy_gravity(){
    var is_grounded = place_meeting(x, y + 1, obj_Platform);
    
    if (!is_grounded) {
        enemy_v_speed += enemy_grav; // Apply gravity when in the air
    } else {
        enemy_v_speed = 0; 
    }
}