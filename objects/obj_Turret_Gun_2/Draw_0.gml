draw_self();
draw_set_color(can_see ? c_lime : c_red);
draw_circle(x, y, sight_range, true);   // sight range
draw_line(x, y, px, py);                // line to the player
draw_set_color(c_white);

draw_set_color(c_white);
draw_text(x - 100, y - 60, "dist: " + string(point_distance(x, y, px, py)) + "  range: " + string(sight_range) + "  in_range: " + string(in_range));

if (blocker != noone) {
    draw_set_color(c_yellow);
    draw_rectangle(blocker.bbox_left, blocker.bbox_top, blocker.bbox_right, blocker.bbox_bottom, true);
    draw_set_color(c_white);
}