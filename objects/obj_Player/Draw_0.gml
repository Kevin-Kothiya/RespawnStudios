
/// obj_Player - Draw Event

if (is_crouching)
{
    var crouch_factor = 0.65;

    // Height of the visible sprite below its origin
    var sprite_bottom =
        sprite_get_height(sprite_index)
        - sprite_get_yoffset(sprite_index);

    // Calculate the height after scaling
    var scaled_bottom =
        sprite_bottom * image_yscale * crouch_factor;

    // Align the visible feet with the collision mask
    var draw_y = bbox_bottom - scaled_bottom;

    draw_sprite_ext(
        sprite_index,
        image_index,
        x,
        draw_y,
        image_xscale,
        image_yscale * crouch_factor,
        image_angle,
        image_blend,
        image_alpha
    );
}
else
{
    draw_self();
}

// Debug: Display current collision boundaries
draw_set_color(c_lime);

draw_rectangle(
    bbox_left,
    bbox_top,
    bbox_right,
    bbox_bottom,
    true
);

draw_set_color(c_white);
