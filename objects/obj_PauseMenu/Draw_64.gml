/// obj_PauseMenu - Draw GUI Event
/// Stable version: frozen gameplay snapshot + dark overlay.
/// Once this works, use Draw_64_WITH_BLUR.gml for the blur shader.

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var cx = gw * 0.5;
var cy = gh * 0.5;

var navy = make_color_rgb(8, 22, 38);
var panel = make_color_rgb(13, 32, 50);
var cyan = make_color_rgb(65, 211, 234);
var gold = make_color_rgb(245, 190, 75);
var muted = make_color_rgb(125, 157, 174);

// Draw the frozen gameplay behind the pause menu.
if (global.game_paused)
{
    if (surface_exists(pause_frame))
    {
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_surface_stretched(pause_frame, 0, 0, gw, gh);
    }

    // Darken the captured frame, but leave it visible.
    draw_set_color(c_black);
    draw_set_alpha(pause_overlay_alpha);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}

// Gear icon (always visible and clickable).
var gx = gw - 55;
var gy = 55;
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gear_hover = point_distance(mx, my, gx, gy) <= 30;

draw_set_color(navy);
draw_rectangle(gx - 31, gy - 31, gx + 31, gy + 31, false);

draw_set_color(gear_hover ? gold : cyan);
draw_rectangle(gx - 31, gy - 31, gx + 31, gy + 31, true);

for (var t = 0; t < 8; t++)
{
    var a = t * 45;
    var tx = gx + lengthdir_x(17, a);
    var ty = gy + lengthdir_y(17, a);
    draw_rectangle(tx - 5, ty - 5, tx + 5, ty + 5, false);
}

draw_circle(gx, gy, 16, false);
draw_set_color(navy);
draw_circle(gx, gy, 7, false);

// Pause panel and buttons.
if (global.game_paused)
{
    var x1 = cx - 260;
    var y1 = cy - 195;
    var x2 = cx + 260;
    var y2 = cy + 245;

    draw_set_color(panel);
    draw_rectangle(x1, y1, x2, y2, false);
    draw_set_color(cyan);
    draw_rectangle(x1, y1, x2, y2, true);

    draw_set_font(fnt_menu);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(gold);
    draw_text(cx, cy - 148, "PAUSED");
    draw_set_color(muted);
    draw_text(cx, cy - 100, "ESC TO RESUME");

    var start_y = cy - 35;
    for (var i = 0; i < array_length(pause_labels); i++)
    {
        var bx1 = cx - pause_btn_w * 0.5;
        var by1 = start_y + i * (pause_btn_h + pause_btn_gap);
        var bx2 = bx1 + pause_btn_w;
        var by2 = by1 + pause_btn_h;
        var active = (i == pause_selected);

        draw_set_color(active ? make_color_rgb(25, 65, 84) : navy);
        draw_rectangle(bx1, by1, bx2, by2, false);
        draw_set_color(active ? gold : muted);
        draw_rectangle(bx1, by1, bx2, by2, true);
        draw_set_color(active ? gold : c_white);
        draw_text(cx, (by1 + by2) * 0.5, pause_labels[i]);
    }

    draw_set_color(muted);
    draw_text(cx, cy + 212, "F11 - FULLSCREEN");
}

// Restore draw settings for other GUI objects.
draw_set_font(-1);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
