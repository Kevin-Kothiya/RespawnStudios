/// obj_TutorialExit - Draw Event

// Door frame
draw_set_color(c_gray);
draw_rectangle(
    x - 22, y - 64,
    x + 22, y,
    false
);

// Glowing doorway
draw_set_color(c_orange);
draw_rectangle(
    x - 16, y - 58,
    x + 16, y - 4,
    false
);

// Reset
draw_set_color(c_white);