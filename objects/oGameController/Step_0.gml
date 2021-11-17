// -----------------------------
// Game Over
// -----------------------------
if(global.isGameOver) {
	// Press any key to retry
	// (except jump/duck keys)
	if(keyboard_check_released(vk_anykey) && !keyboard_check_released(KEY_JUMP) && !keyboard_check_released(KEY_DUCK)) {
		room_restart();
	}
	global.gameSpeed = 0;
}

// -----------------------------
// Title
// -----------------------------
if(global.isTitle) {
	// Press any key to retry
	// (except jump/duck keys)
	if(keyboard_check_released(vk_anykey)) {
		global.isTitle = false;
		instanceTuto.visible = false;
		// Music
		if(!audio_is_playing(sndMusic)) {
			audio_play_sound(sndMusic, 1, true);
		}
	} else {
		return;
	}
}


// -----------------------------
// Return if game over
// -----------------------------
if(global.isGameOver) {
	return; 
}

// -----------------------------
// Score
// -----------------------------
global.scoreDistance += global.gameSpeed / 32;

// -----------------------------
// Speed increase
// -----------------------------
// How many times have we travelled GAME_SPEED_INCREASE_THRESHOLD?
var ratio = floor(global.scoreDistance / GAME_SPEED_INCREASE_THRESHOLD);
// What gameSpeed should be
var targetSpeed = ceil(power(GAME_SPEED_INCREASE_RATIO, ratio) * GAME_SPEED_BASE);

if(targetSpeed > global.gameSpeed) {
	// Burst speed
	global.gameSpeed = targetSpeed;
	show_debug_message("FASTER!!!");
}