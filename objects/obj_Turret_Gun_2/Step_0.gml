// Find the base
if (!instance_exists(base)) {
    base = instance_nearest(x, y, obj_Turret_Base_2);
    if (base == noone) exit;
}

// Always draw the gun in front of the base
depth = base.depth - 1;

// Pivot follows the base's scale/rotation
var ox = pivot_off_x * base.image_xscale;
var oy = pivot_off_y * base.image_yscale;
var a  = base.image_angle;
x = base.x + lengthdir_x(ox, a) + lengthdir_x(oy, a - 90);
y = base.y + lengthdir_y(ox, a) + lengthdir_y(oy, a - 90);

if (fire_timer > 0) fire_timer--;

can_see = false;

if (instance_exists(obj_Player)) {
    px = (obj_Player.bbox_left + obj_Player.bbox_right) / 2;
    py = (obj_Player.bbox_top + obj_Player.bbox_bottom) / 2;

    var in_range = point_distance(x, y, px, py) <= sight_range;

    // Line of sight starts at the muzzle, so the platform the turret hangs from doesn't block it
    var target = point_direction(x, y, px, py);
    var mx = x + lengthdir_x(muzzle_dist, target);
    var my = y + lengthdir_y(muzzle_dist, target);
    var blocked = collision_line(mx, my, px, py, obj_Platform, false, true);
	
	in_range = point_distance(x, y, px, py) <= sight_range;

	// Collect everything on the line, then ignore the player
	var hits = ds_list_create();
	var n = collision_line_list(mx, my, px, py, obj_Platform, false, true, hits, false);

	blocker = noone;
	for (var i = 0; i < n; i++) {
	    if (hits[| i] != obj_Player.id) { blocker = hits[| i]; break; }
	}
	ds_list_destroy(hits);

	can_see = in_range && (blocker == noone || !use_line_of_sight);


    if (can_see) {
        var diff = angle_difference(target, aim_dir);
        aim_dir += clamp(diff, -turn_speed, turn_speed);

        if (fire_timer <= 0 && abs(diff) < 5) {
            var bx = x + lengthdir_x(muzzle_dist, aim_dir);
            var by = y + lengthdir_y(muzzle_dist, aim_dir);

            var b = instance_create_layer(bx, by, "Visible_Instances", obj_Enemy_Bullet);
            b.direction   = aim_dir;
            b.image_angle = aim_dir;
            b.speed       = bullet_speed;

            fire_timer = fire_rate;
        }
    }
}

image_angle  = aim_dir;
image_yscale = (lengthdir_x(1, aim_dir) < 0) ? -1 : 1;