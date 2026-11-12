function enemy_ai(){
    var grounded = place_meeting(x, y + 1, obj_Platform);
    if (enemy_jump_cooldown > 0) enemy_jump_cooldown--;

    // Player position relative to the enemy (centers / feet)
    var dx_player = (obj_Player.bbox_left + obj_Player.bbox_right) / 2 - (bbox_left + bbox_right) / 2;
    var dy_player = obj_Player.bbox_bottom - bbox_bottom;   // negative = player is above

    // Horizontal direction toward the player (dead zone stops jittering)
    var dir = (abs(dx_player) > 8) ? sign(dx_player) : 0;

    if (grounded) {
        var front_x    = (dir > 0) ? bbox_right : bbox_left;
        var wall_ahead = (dir != 0) && place_meeting(x + dir, y, obj_Platform);
        var edge_ahead = (dir != 0) && !position_meeting(front_x + dir * 4, bbox_bottom + 2, obj_Platform);
        var player_above = dy_player < -40;
        var player_below = dy_player > 40;

        var want_jump = false;
        var jump_dir  = dir;

        if (wall_ahead) {
            // Jump over walls
            want_jump = true;
        }
        else if (player_above) {
            // Look for a higher platform, toward the player first, then the other way
            var first = (dir != 0) ? dir : 1;
            if (enemy_find_landing(first, 16)) {
                want_jump = true; jump_dir = first;
            } else if (enemy_find_landing(-first, 16)) {
                want_jump = true; jump_dir = -first;
            }
        }
        else if (edge_ahead) {
            if (!player_below && enemy_find_landing(dir, 0)) {
                want_jump = true;            // hop the gap
            } else if (!player_below) {
                dir = 0;                     // no safe landing, so don't walk off
            }
            // player is below: just walk off and drop down
        }

        if (want_jump && enemy_jump_cooldown <= 0) {
            enemy_air_dir = jump_dir;
            dir = jump_dir;
            enemy_jump();
            enemy_jump_cooldown = 20;
        } else {
            enemy_air_dir = dir;
        }
    } else {
        // In the air: keep the direction the jump was planned for
        dir = enemy_air_dir;
    }

    enemy_h_speed = enemy_move_speed * dir;
}

/// Returns true if a jump in direction d can land on a platform.
/// min_up = how many pixels higher than the current feet the landing must be
/// (use 16 for "climb up", 0 for "cross a gap on the same level").
function enemy_find_landing(d, min_up){
    var v      = abs(enemy_jump_force);
    var feet   = bbox_bottom;
    var body_h = bbox_bottom - bbox_top;
    var front  = (d > 0) ? bbox_right : bbox_left;

    for (var hy = min_up; hy <= 160; hy += 8) {          // landing height above current feet
        var disc = v * v - 2 * enemy_grav * hy;
        if (disc < 0) break;                              // too high to reach

        // Frames in the air to come down onto that height, converted to horizontal reach
        var t     = (v + sqrt(disc)) / enemy_grav;
        var reach = enemy_move_speed * t * 0.85;          // 15% safety margin

        for (var dx = 24; dx <= reach; dx += 16) {
            var px = front + d * dx;
            var py = feet - hy;
            if (position_meeting(px, py + 4, obj_Platform)        // solid just below
             && !position_meeting(px, py - 4, obj_Platform)       // free just above
             && !position_meeting(px, py - body_h, obj_Platform)) // room for the body
            {
                return true;
            }
        }
    }
    return false;
}


function enemy_jump(){
    enemy_v_speed = enemy_jump_force;
}

