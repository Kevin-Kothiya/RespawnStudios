/// obj_Player - Draw Event

// Draw the selected animation normally
draw_self();

// Temporary collision box outline
draw_set_color(c_lime);

draw_rectangle(
    bbox_left,
    bbox_top,
    bbox_right,
    bbox_bottom,
    true
);

draw_set_color(c_white);
