// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.screenShakeFrames = 0;
global.screenShakeMagnitude = 0;
global.screenShakeFade = 0;
	
function shakeScreen(frames, magnitude, fade = 0){
	global.screenShakeFrames = frames;
	global.screenShakeMagnitude = magnitude;
	global.screenShakeFade = fade;
}

function shakeScreenStep() {
	/*
	if(global.screenShakeFrames == 0) {
		camera_set_view_pos(view_camera[0], 0, 0);
	} else if(global.screenShakeFrames > 0) {
		var shakeH = irandom_range(-global.screenShakeMagnitude, global.screenShakeMagnitude);
		var shakeV = irandom_range(-global.screenShakeMagnitude, global.screenShakeMagnitude);
		camera_set_view_pos(view_camera[0], shakeH, shakeV);
		global.screenShakeFrames--;
		global.screenShakeMagnitude = max(global.screenShakeMagnitude - global.screenShakeFade, 0);
	}
	*/
}