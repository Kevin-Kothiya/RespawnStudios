var within_x = false;
var within_y = false;

// checking if the mouse coordinates are within the object
if (mouse_x >= x && mouse_x <= x + sprite_width){
	within_x = true;
} 
if (mouse_y >= y && mouse_y <= y + sprite_height){
	within_y = true;
}
if (within_y and within_x) {
	inside_button = true;
}


var clicked_button = mouse_check_button_pressed(mb_left);

if (inside_button == true && clicked_button == true){
	room_goto(target_room);
}