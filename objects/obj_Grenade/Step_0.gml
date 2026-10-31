// Gravity
v_speed += grav;

// HORIZONTAL COLLISION (bounce off walls)
if (place_meeting(x + h_speed, y, obj_Platform)) {
    while (!place_meeting(x + sign(h_speed), y, obj_Platform)) {
        x += sign(h_speed);
    }
    h_speed *= -bounce_damp;
}
x += h_speed;

// VERTICAL COLLISION (bounce off floors and ceilings)
if (place_meeting(x, y + v_speed, obj_Platform)) {
    while (!place_meeting(x, y + sign(v_speed), obj_Platform)) {
        y += sign(v_speed);
    }
    v_speed *= -bounce_damp;
    h_speed *= 0.8;                       // ground friction
    if (abs(v_speed) < 1) v_speed = 0;    // stop tiny bounces
}
y += v_speed;

if (abs(h_speed) < 0.1) h_speed = 0;

// Spin while moving
image_angle -= h_speed * 2;

// Fuse
fuse -= 1;
if (fuse <= 0) {
    // TODO: explosion effect / damage nearby enemies here
    instance_destroy();
}