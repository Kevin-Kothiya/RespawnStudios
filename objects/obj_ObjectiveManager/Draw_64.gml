
/// obj_ObjectiveManager - Draw GUI Event

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Background panel
draw_set_alpha(0.75);
draw_set_color(make_color_rgb(12, 22, 32));

draw_rectangle(
    20, 80,
    350, 145,
    false
);

// Reset opacity
draw_set_alpha(1);

// Objective heading
draw_set_color(c_aqua);
draw_text(32, 91, "OBJECTIVE");

// Current objective
draw_set_color(c_white);
draw_text(32, 114, objective_text);

// Reset drawing settings
draw_set_color(c_white);
draw_set_alpha(1);


/// TUTORIAL COMPLETE SCREEN

if (objective_id == "complete")
{
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    // Dark transparent background
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    // Center text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Main heading
    draw_set_color(c_aqua);

    draw_text_transformed(
        gw / 2,
        gh / 2 - 65,
        "TUTORIAL COMPLETE!",
        2, 2, 0
    );

    // Description
    draw_set_color(c_white);

    draw_text(
        gw / 2,
        gh / 2,
        "Vector is ready to begin his mission."
    );

    // Continue instruction
    draw_set_color(c_yellow);

    draw_text(
        gw / 2,
        gh / 2 + 55,
        "Press ENTER to return to the Main Menu"
    );

    // Reset drawing settings
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
