// 1. Draw a dark background bar (e.g., 200 pixels wide, 20 pixels tall)
draw_set_color(c_dkgray);
draw_rectangle(20, 20, 220, 40, false);

// 2. Draw the green health bar on top based on current health percentage
// Assuming health goes from 0 to 100:
var health_width = 200 * (obj_Player.player_health / 100); 
draw_set_color(c_lime);
draw_rectangle(20, 20, 20 + health_width, 40, false);