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
// Game speed (temporary) alteration
// -----------------------------
speedAlterationFrames--;

// FOR DEBUG!
if(keyboard_check_released(vk_space)) {
	// Short boost
	// gameAlterSpeed(global.gameSpeed + 10, 20, +2);
	// Max Payne effect
	// gameAlterSpeed(global.gameSpeed, 60, -0.5);
	
	enqueueSpeedAlteration(global.gameSpeed, 8, -2);
	enqueueSpeedAlteration(global.gameSpeed - 8, 5, +4);
	enqueueSpeedAlteration(global.gameSpeed + 12, 20, -1);
}


// No speed alteration playing
if(speedAlterationFrames <= 0) {
	if(ds_list_size(speedAlterations) > 0) {
		// Start next speed alteration from queue
		global.gameSpeed = speedAlterations[|0][0];
		speedAlterationFrames = speedAlterations[|0][1];
		speedAlterationVariation = speedAlterations[|0][2];
		// Remove it immediately
		ds_list_delete(speedAlterations, 0);
	} else {
		// Reset speed
		global.gameSpeed = nonAlteredSpeed;
	}

} else {
	// Speed is altered
	global.gameSpeed = max(1, global.gameSpeed + speedAlterationVariation);
}

// -----------------------------
// Speed increase
// -----------------------------
// If speed is altered for FX, we wait.
if(speedAlterationFrames <= 0) {
	// How many times have we travelled GAME_SPEED_INCREASE_THRESHOLD?
	var ratio = floor(global.scoreDistance / GAME_SPEED_INCREASE_THRESHOLD);
	// What gameSpeed should be
	var targetSpeed = ceil(power(GAME_SPEED_INCREASE_RATIO, ratio) * GAME_SPEED_BASE);

	if(targetSpeed > global.gameSpeed) {
		// Burst speed
		global.gameSpeed = targetSpeed;
		show_debug_message("FASTER!!!");
	}

}


