/// obj_PauseMenu - Step Event

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Gear icon position in GUI coordinates.
var gear_x = gw - 55;
var gear_y = 55;
var over_gear = point_distance(mx, my, gear_x, gear_y) <= 30;

// ESC or clicking the gear toggles the pause menu.
if (keyboard_check_pressed(vk_escape)
    || (mouse_check_button_pressed(mb_left) && over_gear))
{
    global.game_paused = !global.game_paused;
    pause_selected = 0;
}

if (global.game_paused)
{
    var start_y = gh * 0.5 - 35;
    var hovered = -1;

    // Determine which button is under the mouse.
    for (var i = 0; i < array_length(pause_labels); i++)
    {
        var bx = gw * 0.5 - pause_btn_w * 0.5;
        var by = start_y + i * (pause_btn_h + pause_btn_gap);

        if (mx >= bx && mx <= bx + pause_btn_w
            && my >= by && my <= by + pause_btn_h)
        {
            hovered = i;
            break;
        }
    }

    // Keyboard selection.
    if (keyboard_check_pressed(vk_down)
        || keyboard_check_pressed(ord("S")))
    {
        pause_selected = (pause_selected + 1) mod array_length(pause_labels);
    }

    if (keyboard_check_pressed(vk_up)
        || keyboard_check_pressed(ord("W")))
    {
        pause_selected = (pause_selected + array_length(pause_labels) - 1)
                       mod array_length(pause_labels);
    }

    // Mouse hover selection, only when mouse has moved.
    if ((mx != last_mouse_x || my != last_mouse_y) && hovered != -1)
    {
        pause_selected = hovered;
    }

    var chosen = -1;

    if (mouse_check_button_pressed(mb_left) && hovered != -1)
    {
        chosen = hovered;
    }

    if (keyboard_check_pressed(vk_enter)
        || keyboard_check_pressed(vk_space))
    {
        chosen = pause_selected;
    }

    if (chosen != -1)
    {
        switch (chosen)
        {
            case 0: // RESUME
                global.game_paused = false;
                break;

            case 1: // MAIN MENU
                global.game_paused = false;
                if (pause_world_frozen)
                {
                    instance_activate_all();
                    pause_world_frozen = false;
                }
                room_goto(Main_Menu);
                exit;

            case 2: // QUIT GAME
                game_end();
                exit;
        }
    }
}

last_mouse_x = mx;
last_mouse_y = my;

// ==========================================================
// CENTRALIZED PAUSE: freeze/unfreeze gameplay instances ONCE.
// ==========================================================
if (global.game_paused && !pause_world_frozen)
{
    // Capture the LAST fully rendered gameplay frame BEFORE freezing.
    // This surface is drawn by Draw GUI while gameplay is deactivated.
    if (surface_exists(application_surface))
    {
        var sw = surface_get_width(application_surface);
        var sh = surface_get_height(application_surface);

        if (surface_exists(pause_frame))
        {
            surface_free(pause_frame);
        }

        pause_frame = surface_create(sw, sh);
        surface_copy(pause_frame, 0, 0, application_surface);
    }

    // Freeze player, enemies, bullets, gravity, alarms, etc.
    // 'true' keeps this pause controller active.
    instance_deactivate_all(true);

    // Keep F11 working while the rest of the room is paused.
    // This object is the F11 controller from your existing project.
    instance_activate_object(obj_FullScreenController);

    pause_world_frozen = true;
}
else if (!global.game_paused && pause_world_frozen)
{
    // Resume all gameplay instances.
    instance_activate_all();
    pause_world_frozen = false;
}
