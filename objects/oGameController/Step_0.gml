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
// store gamespeed locally to be able to use tweens
// (workaround the impossibility to access global inside tween script)
gameSpeed = global.gameSpeed;
	
// This is for testing purposes!
if(keyboard_check_released(vk_space)) {
	if(!tweenTimelineIsRunning(tlGameSpeed) && !tweenTimelineIsRunning(tlPlayerX)) {
		show_debug_message("VROOOOOOOOOM!!!");
		// Screenshake for the lulz
		cameraStartShake(40, 3, .03);
	
		// Game speed
		var gameSpeedFaster = gameSpeed + 7;
		tweenAdd(tlGameSpeed, id, "gameSpeed", gameSpeed, gameSpeedFaster, 20, easeInOutBack, true);
		tweenAdd(tlGameSpeed, id, "gameSpeed", gameSpeedFaster, gameSpeed, 120, easeInOutCubic);
		
		// Player X
		with(oCharacter) {
			tweenAdd(other.tlPlayerX, id, "x", x, x + 70, 30, easeOutCubic, true);
			tweenAdd(other.tlPlayerX, id, "x", x + 70, x, 80, easeInOutQuad);
		}
		
		// Particles
		part_emitter_stream(windParticleSystem, windEmitter, windParticle, -2);
	}
} else {
	part_emitter_stream(windParticleSystem, windEmitter, windParticle, -8);
}

// Wind particles, depending of gamespeed
// For 
var minR = -12;
var maxR = -1;
var minSpeed = GAME_SPEED_BASE;
var maxSpeed = 20;
var r = minR + (maxR - minR) * (global.gameSpeed - minSpeed) / (maxSpeed - minSpeed);
part_emitter_stream(windParticleSystem, windEmitter, windParticle, r);

// Tween step
tweenStep(tlGameSpeed);
tweenStep(tlPlayerX);
// set global speed
global.gameSpeed = gameSpeed;

// -----------------------------
// Speed increase
// -----------------------------
// If speed is altered for FX, we wait.
if(!tweenTimelineIsRunning(tlGameSpeed)) {
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


