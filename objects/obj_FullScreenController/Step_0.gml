
/// obj_FullscreenController - Step Event

// Press F11 to toggle fullscreen
if (keyboard_check_pressed(vk_f11))
{
    if (window_get_fullscreen())
    {
        // Exit fullscreen
        window_set_fullscreen(false);
    }
    else
    {
        // Enter fullscreen
        window_set_fullscreen(true);
    }
}
