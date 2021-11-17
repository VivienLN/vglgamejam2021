// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.screenShakeFrames = 0;
global.screenShakeMagnitude = 0;
global.screenShakeFade = 0;
	
function shakeScreen(frames, magnitude, fade = 0){
	show_debug_message("shakeScreen");
	global.screenShakeFrames = frames;
	global.screenShakeMagnitude = magnitude;
	global.screenShakeFade = fade;
}

function shakeScreenStep() {
	show_debug_message("shakeScreenStep");
	var initialX = camera_get_view_x(view_camera[0]);
	var initialY = camera_get_view_y(view_camera[0]);
	if(global.screenShakeFrames > 0) {
		var shakeH = irandom_range(-global.screenShakeMagnitude, global.screenShakeMagnitude);
		var shakeV = irandom_range(-global.screenShakeMagnitude, global.screenShakeMagnitude);
		camera_set_view_pos(view_camera[0], initialX + shakeH, initialY + shakeV);
		global.screenShakeFrames--;
		global.screenShakeMagnitude = max(global.screenShakeMagnitude - global.screenShakeFade, 0);
	}
}