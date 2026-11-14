
/// obj_TestTerminal - Draw Event

// Terminal body
draw_set_color(c_gray);
draw_rectangle(x - 18, y - 30, x + 18, y + 8, false);

// Screen changes colour when activated
if (terminal_active)
{
    draw_set_color(c_lime);
}
else
{
    draw_set_color(c_aqua);
}

draw_rectangle(x - 12, y - 24, x + 12, y - 9, false);

// Reset drawing colour
draw_set_color(c_white);
