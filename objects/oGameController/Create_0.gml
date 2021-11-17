// Constants
#macro KEY_JUMP vk_up
#macro KEY_DUCK vk_down
#macro GAME_SPEED_BASE 10 // px/frame
#macro GAME_SPEED_INCREASE_THRESHOLD 500
#macro GAME_SPEED_INCREASE_RATIO 1.05
#macro FX_BIRDS_CHANCE 10

// Camera
#macro CAMERA_OFFSET_Y -32
#macro CAMERA_DEFAULT view_camera[0]
#macro CAMERA_BORDER 260

// Debugging tools
#macro GAME_OVER_ENABLED true 

// Variables
global.gameSpeed = GAME_SPEED_BASE;
global.isGameOver = false;
global.isTitle = true;

// Score
global.scoreDistance = 0;

// Game speed (temporary) alteration function
speedAlterations = ds_list_create();
nonAlteredSpeed = global.gameSpeed;
speedAlterationFrames = 0;
speedAlterationFramesTotal = 0;

// For easing
speedAlterationEasing = noone;
speedAlterationStart = 0;
speedAlterationEnd = 0;

// Stop speed alteration and return to previous speed
function cancelSpeedAlterations() {
	ds_list_clear(speedAlterations);
	global.gameSpeed = nonAlteredSpeed;
	speedAlterationFrames = 0;
	speedAlterationFramesTotal = 0;
}

// Enqueue new speed alteration
// That will be played after the current one (if needed)
function enqueueSpeedAlteration(endValue, duration, easing, cancelOthers = false) {
	// If speed is not already altered, save it
	if(ds_list_size(speedAlterations) == 0) {
		nonAlteredSpeed = global.gameSpeed;
	}
	
	// Cancel all other animations if wanted
	if(cancelOthers) {
		cancelSpeedAlterations();	
	}
	
	// Enqueue animation
	ds_list_add(speedAlterations, [endValue, duration, easing]);
}