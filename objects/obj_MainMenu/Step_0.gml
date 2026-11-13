
/// obj_MainMenu - Step Event

if (menu_panel == 0) {

    // Check whether the mouse is over a button
    var mouse_hit = -1;

    var half_w = sprite_get_width(spr_menu_button) * menu_scale * 0.5;
    var half_h = sprite_get_height(spr_menu_button) * menu_scale * 0.5;

    for (var i = 0; i < button_count; i++) {

        var cy = menu_top + i * menu_gap;

        if (mouse_x >= menu_x - half_w &&
            mouse_x <= menu_x + half_w &&
            mouse_y >= cy - half_h &&
            mouse_y <= cy + half_h) {

            mouse_hit = i;
            break;
        }
    }

    // Mouse hover selects a button
    if (mouse_x != last_mouse_x || mouse_y != last_mouse_y) {
        selected = mouse_hit;
    }

    // Down Arrow or S
    if (keyboard_check_pressed(vk_down) ||
        keyboard_check_pressed(ord("S"))) {

        if (selected < 0) {
            selected = 0;
        } else {
            selected = (selected + 1) mod button_count;
        }
    }

    // Up Arrow or W
    if (keyboard_check_pressed(vk_up) ||
        keyboard_check_pressed(ord("W"))) {

        if (selected < 0) {
            selected = button_count - 1;
        } else {
            selected = (selected + button_count - 1) mod button_count;
        }
    }

    // Enter or Space activates selected button
    var activate = keyboard_check_pressed(vk_enter) ||
                   keyboard_check_pressed(vk_space);

    // Mouse click
    if (mouse_check_button_pressed(mb_left)) {

        activate = (mouse_hit >= 0);

        if (mouse_hit >= 0) {
            selected = mouse_hit;
        }
    }

    // Button actions
    if (activate && selected >= 0) {

        switch (selected) {

            case 0: // START
                room_goto(Tutorial_Level);
                break;

            case 1: // CONTINUE
                menu_panel = 3;
                break;

            case 2: // OPTIONS
                menu_panel = 1;
                break;

            case 3: // CREDITS
                menu_panel = 2;
                break;

            case 4: // QUIT
                game_end();
                break;
        }
    }

} else {

    // Temporary Options screen
    if (menu_panel == 1 &&
        keyboard_check_pressed(ord("F"))) {

        window_set_fullscreen(!window_get_fullscreen());
    }

    // Return to main menu
    if (keyboard_check_pressed(vk_escape) ||
        keyboard_check_pressed(vk_enter) ||
        mouse_check_button_pressed(mb_left)) {

        menu_panel = 0;
    }
}

// Save mouse position
last_mouse_x = mouse_x;
last_mouse_y = mouse_y;

// Smooth glow transition
for (var j = 0; j < button_count; j++) {

    var target = (j == selected && menu_panel == 0) ? 1 : 0;

    glow[j] = lerp(glow[j], target, 0.22);

    if (abs(glow[j] - target) < 0.005) {
        glow[j] = target;
    }
}
