
/// obj_DialogueManager - Draw GUI Event

if (!dialogue_visible) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Dialogue panel dimensions
var panel_x = 24;
var panel_w = gw - 48;
var panel_h = min(190, gh * 0.30);
var panel_y = gh - panel_h - 24;

// Dark background
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(12, 28, 45));

draw_rectangle(
    panel_x,
    panel_y,
    panel_x + panel_w,
    panel_y + panel_h,
    false
);

// Cyan border
draw_set_alpha(1);
draw_set_color(make_color_rgb(65, 210, 225));

draw_rectangle(
    panel_x,
    panel_y,
    panel_x + panel_w,
    panel_y + panel_h,
    true
);

// Temporary portrait placeholder
var portrait_x = panel_x + 16;
var portrait_y = panel_y + 20;
var portrait_size = min(110, panel_h - 40);

draw_set_color(make_color_rgb(30, 65, 85));

draw_rectangle(
    portrait_x,
    portrait_y,
    portrait_x + portrait_size,
    portrait_y + portrait_size,
    false
);

// Portrait border
draw_set_color(c_aqua);

draw_rectangle(
    portrait_x,
    portrait_y,
    portrait_x + portrait_size,
    portrait_y + portrait_size,
    true
);

// Font settings
draw_set_font(fnt_menu);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Speaker name
var text_x = portrait_x + portrait_size + 20;
var text_y = panel_y + 20;

draw_set_color(make_color_rgb(255, 205, 90));

draw_text_transformed(
    text_x,
    text_y,
    dialogue_speaker,
    0.75,
    0.75,
    0
);

// Current dialogue line
draw_set_color(c_white);

var current_line = dialogue_lines[dialogue_line_index];
var text_scale = 0.6;
var available_width = panel_x + panel_w - text_x - 20;

draw_text_ext_transformed(
    text_x,
    text_y + 42,
    current_line,
    -1,
    available_width / text_scale,
    text_scale,
    text_scale,
    0
);

// Continue prompt
draw_set_color(c_aqua);
draw_set_halign(fa_right);

draw_text_transformed(
    panel_x + panel_w - 18,
    panel_y + panel_h - 28,
    "[E] Continue",
    0.45,
    0.45,
    0
);

// Reset drawing settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
