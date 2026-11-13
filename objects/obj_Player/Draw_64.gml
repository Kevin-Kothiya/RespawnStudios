
/// obj_Player - Draw GUI
/// Floating interaction prompt

var is_paused = false;

if (variable_global_exists("game_paused"))
{
    is_paused = global.game_paused;
}

// NEW: Check whether dialogue is active
var is_talking = false;

if (variable_global_exists("dialogue_active"))
{
    is_talking = global.dialogue_active;
}

// Only show the prompt when not paused or talking
if (!is_paused && !is_talking && instance_exists(interact_target))
{
    // Get the target's position in the room
    var target_x = interact_target.x;
    var target_y = interact_target.y;

    // Get GUI dimensions
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    // Default to the entire room
    var cam_x = 0;
    var cam_y = 0;
    var cam_w = room_width;
    var cam_h = room_height;

    // Account for a camera following the player
    if (view_enabled && view_visible[0])
    {
        var cam = view_camera[0];

        cam_x = camera_get_view_x(cam);
        cam_y = camera_get_view_y(cam);
        cam_w = camera_get_view_width(cam);
        cam_h = camera_get_view_height(cam);
    }

    // Convert room coordinates to GUI coordinates
    var scale_x = gw / cam_w;
    var scale_y = gh / cam_h;

    var screen_x = (target_x - cam_x) * scale_x;
    var screen_y = (target_y - cam_y) * scale_y;

    // Prompt text
    var prompt = "[E] " + interact_target.interaction_label;

    draw_set_font(fnt_menu);

    var text_scale = 0.55;
    var text_w = string_width(prompt) * text_scale;
    var text_h = string_height(prompt) * text_scale;

    // Background dimensions
    var padding_x = 14;
    var box_w = text_w + padding_x * 2;
    var box_h = max(34, text_h + 14);

    // Position above and to the right of the object
    var box_x = screen_x + 28 * scale_x;
    var box_y = screen_y - 65 * scale_y;

    // Keep the prompt inside the screen
    box_x = clamp(box_x, 8, max(8, gw - box_w - 8));
    box_y = clamp(box_y, 8, max(8, gh - box_h - 8));

    // Draw dark background (Adjust opacity and color)
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(12, 25, 42));

    draw_rectangle(
        box_x,
        box_y,
        box_x + box_w,
        box_y + box_h,
        false
    );

    // Cyan outline
    draw_set_alpha(1);
    draw_set_color(c_aqua);

    draw_rectangle(
        box_x,
        box_y,
        box_x + box_w,
        box_y + box_h,
        true
    );

    // Draw prompt text
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_text_transformed(
        box_x + padding_x,
        box_y + box_h / 2,
        prompt,
        text_scale,
        text_scale,
        0
    );

    // Reset drawing settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
}
