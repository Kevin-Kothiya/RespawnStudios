function enemy_ai(){
    var grounded = place_meeting(x, y + 1, obj_Platform);
    if (enemy_jump_cooldown > 0) enemy_jump_cooldown--;
    if (fire_timer > 0) fire_timer--;

    if (!instance_exists(obj_Player)) { enemy_h_speed = 0; return; }

    // Centers and distance
    var cx = (bbox_left + bbox_right) / 2;
    var cy = (bbox_top + bbox_bottom) / 2;
    var px = (obj_Player.bbox_left + obj_Player.bbox_right) / 2;
    var py = (obj_Player.bbox_top + obj_Player.bbox_bottom) / 2;
    var dist = point_distance(cx, cy, px, py);
    var dx_player = px - cx;
    var dy_player = obj_Player.bbox_bottom - bbox_bottom;   // negative = player is above

    var sees = enemy_can_see_player(px, py, dist);
    var dir  = 0;

    // Shoot whenever the player is visible
    if (sees) {
        enemy_aim_dir = point_direction(cx, cy, px, py);
        if (fire_timer <= 0) {
            enemy_shoot(cx, cy, px, py);
            fire_timer = fire_rate;
        }
    }

    if (grounded) {
        if (sees) {
            // Keep a comfortable shooting distance
            if (dist > keep_distance + 80)      dir =  sign(dx_player);
            else if (dist < keep_distance - 80) dir = -sign(dx_player);

            // Don't walk into walls or off ledges while repositioning
            if (dir != 0) {
                var fx = (dir > 0) ? bbox_right : bbox_left;
                var edge = !position_meeting(fx + dir * 4, bbox_bottom + 2, obj_Platform);
                var wall = place_meeting(x + dir, y, obj_Platform);
                if (edge || wall) dir = 0;
            }
            enemy_air_dir = dir;
        } else {
            // Can't see the player: chase and jump from platform to platform
            var player_above = dy_player < -40;
            var player_below = dy_player > 40;
            var using_patrol = false;

            if (enemy_commit_timer > 0 && (player_above || player_below)) {
                // Stick with the direction chosen earlier instead of flip-flopping
                enemy_commit_timer--;
                dir = enemy_commit_dir;
                using_patrol = player_above;
            }
            else {
                enemy_commit_timer = 0;
                dir = (abs(dx_player) > 8) ? sign(dx_player) : 0;

                // Player is straight above or below, so there's no side to follow: pick one and commit
                if (dir == 0) {
                    if (player_below) {
                        dir = enemy_nearest_edge_dir();             // closest ledge to drop from
                        if (dir == 0) dir = enemy_patrol_dir;
                    }
                    else if (player_above) {
                        dir = enemy_patrol_dir;                     // wander and look for a way up
                        using_patrol = true;
                    }
                    if (dir != 0) {
                        enemy_commit_dir   = dir;
                        enemy_commit_timer = 180;                   // about 3 seconds at 60 FPS
                    }
                }
            }

            var front_x    = (dir > 0) ? bbox_right : bbox_left;
            var wall_ahead = (dir != 0) && place_meeting(x + dir, y, obj_Platform);
            var edge_ahead = (dir != 0) && !position_meeting(front_x + dir * 4, bbox_bottom + 2, obj_Platform);

            var want_jump = false;
            var jump_dir  = dir;

            if (wall_ahead) {
                want_jump = true;
            }
            else if (player_above) {
                var first = (dir != 0) ? dir : 1;
                if (enemy_find_landing(first, 16))       { want_jump = true; jump_dir = first; }
                else if (enemy_find_landing(-first, 16)) { want_jump = true; jump_dir = -first; }
            }
            else if (edge_ahead) {
                if (!player_below && enemy_find_landing(dir, 0)) want_jump = true;
                else if (!player_below) dir = 0;
            }

            // Wandering to find a way up: turn around at a ledge, and commit to the new direction
            if (!want_jump && using_patrol && edge_ahead) {
                enemy_patrol_dir   = -enemy_patrol_dir;
                enemy_commit_dir   = enemy_patrol_dir;
                enemy_commit_timer = 180;
                dir = 0;
            }

            if (want_jump && enemy_jump_cooldown <= 0) {
                enemy_air_dir = jump_dir;
                dir = jump_dir;
                enemy_jump();
                enemy_jump_cooldown = 20;
                enemy_commit_timer = 0;
            } else {
                enemy_air_dir = dir;
            }
        }
    }  else {
        // In the air: keep the direction the jump was planned for
        dir = enemy_air_dir;
        enemy_commit_timer = 0;
    }

    enemy_h_speed = enemy_move_speed * dir;
}

/// True if the player is in range and nothing solid is between the enemy and the player
function enemy_can_see_player(px, py, dist){
    if (dist > sight_range) return false;

    var eye_x = (bbox_left + bbox_right) / 2;
    var eye_y = bbox_top + 30;   // roughly head height

    // Enemy and player are children of obj_Platform, so ignore both
    var hits = ds_list_create();
    var n = collision_line_list(eye_x, eye_y, px, py, obj_Platform, false, true, hits, false);
    var clear = true;
    for (var i = 0; i < n; i++) {
        var o = hits[| i];
        if (o != id && o != obj_Player.id) { clear = false; break; }
    }
    ds_list_destroy(hits);
    return clear;
}

/// Fires one bullet from the enemy's center toward the player, at any angle
function enemy_shoot(cx, cy, px, py){
    var aim = point_direction(cx, cy, px, py);
    var dx  = lengthdir_x(1, aim);
    var dy  = lengthdir_y(1, aim);

    // Spawn just outside the enemy's box so the bullet doesn't hit its own shooter
    var half_w = (bbox_right - bbox_left) / 2;
    var half_h = (bbox_bottom - bbox_top) / 2;
    var dist_x = (abs(dx) > 0.0001) ? half_w / abs(dx) : 99999;
    var dist_y = (abs(dy) > 0.0001) ? half_h / abs(dy) : 99999;
    var spawn_dist = min(dist_x, dist_y) + 25 + 6;   // 25 = half the bullet's width

    var b = instance_create_layer(cx + dx * spawn_dist, cy + dy * spawn_dist, "Visible_Instances", obj_Enemy_Bullet);
    b.direction   = aim;
    b.image_angle = aim;
    b.speed       = bullet_speed;
}

/// Returns true if a jump in direction d can land on a platform.
/// min_up = how many pixels higher than the current feet the landing must be
/// (use 16 for "climb up", 0 for "cross a gap on the same level").
function enemy_find_landing(d, min_up){
    var v      = abs(enemy_jump_force);
    var feet   = bbox_bottom;
    var body_h = bbox_bottom - bbox_top;
    var front  = (d > 0) ? bbox_right : bbox_left;

    for (var hy = min_up; hy <= 160; hy += 8) {
        var disc = v * v - 2 * enemy_grav * hy;
        if (disc < 0) break;

        var t     = (v + sqrt(disc)) / enemy_grav;
        var reach = enemy_move_speed * t * 0.85;

        for (var dx = 24; dx <= reach; dx += 16) {
            var px = front + d * dx;
            var py = feet - hy;
            if (position_meeting(px, py + 4, obj_Platform)
             && !position_meeting(px, py - 4, obj_Platform)
             && !position_meeting(px, py - body_h, obj_Platform))
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

/// Direction (-1 or 1) of the closest ledge the enemy can walk to without hitting a wall, or 0 if none
function enemy_nearest_edge_dir(){
    var best_dir  = 0;
    var best_dist = 99999;

    for (var d = -1; d <= 1; d += 2) {
        var front = (d > 0) ? bbox_right : bbox_left;
        for (var s = 4; s <= 800; s += 8) {
            if (place_meeting(x + d * s, y, obj_Platform)) break;                        // wall in the way
            if (!position_meeting(front + d * s, bbox_bottom + 2, obj_Platform)) {       // floor ends here
                if (s < best_dist) { best_dist = s; best_dir = d; }
                break;
            }
        }
    }
    return best_dir;
}