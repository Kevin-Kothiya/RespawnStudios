
/// obj_MainMenu - Draw Event

// Use your custom font
draw_set_font(fnt_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw all five buttons
for (var i = 0; i < button_count; i++) {

    var cy = menu_top + i * menu_gap;

    // Slightly enlarge the selected button
    var s = menu_scale * (1 + 0.025 * glow[i]);

    // Draw OFF state
    draw_sprite_ext(
        spr_menu_button, 0,
        menu_x, cy,
        s, s, 0,
        c_white, 1
    );

    // Fade ON state over OFF state
    if (glow[i] > 0.001) {

        draw_sprite_ext(
            spr_menu_button, 1,
            menu_x, cy,
            s, s, 0,
            c_white, glow[i]
        );
    }

    // Text shadow
    draw_set_color(make_color_rgb(4, 12, 23));

    draw_text_transformed(
        menu_x + 2, cy + 2,
        labels[i],
        s, s, 0
    );

    // Text colour changes with selection
    var off_color = make_color_rgb(145, 164, 180);
    var on_color = make_color_rgb(238, 252, 255);

    draw_set_color(
        merge_color(off_color, on_color, glow[i])
    );

    draw_text_transformed(
        menu_x, cy,
        labels[i],
        s, s, 0
    );
}

// Temporary screens for unfinished menu items
if (menu_panel != 0) {

    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(5, 16, 29));

    draw_rectangle(
        0, 0,
        room_width, room_height,
        false
    );

    draw_set_alpha(1);

    draw_set_color(make_color_rgb(61, 221, 241));

    draw_rectangle(
        room_width * 0.18,
        room_height * 0.33,
        room_width * 0.82,
        room_height * 0.67,
        true
    );

    draw_set_color(c_white);

    switch (menu_panel) {

        case 1:
            draw_text(menu_x, room_height * 0.43, "OPTIONS");
            draw_text(menu_x, room_height * 0.52,
                      "Press F to toggle fullscreen");
            break;

        case 2:
            draw_text(menu_x, room_height * 0.43, "CREDITS");
            draw_text(menu_x, room_height * 0.52,
                      "The Invasion of VOS - Respawn Studios");
            break;

        case 3:
            draw_text(menu_x, room_height * 0.43, "CONTINUE");
            draw_text(menu_x, room_height * 0.52,
                      "No saved game available yet");
            break;
    }

    draw_text(menu_x, room_height * 0.61,
              "Esc / Enter / Click to return");
}

// Reset drawing settings
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
