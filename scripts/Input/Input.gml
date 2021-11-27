// -----------------------------
// Gamepad detection
// First pad detected is then used
// -----------------------------
// Get or set the gamepad device to use if needed
function getPadDevice() {
	static padDevice = noone;
	// a device has been found and is connected
	if(padDevice != noone && gamepad_is_connected(padDevice)) {
		return padDevice;
	}
	
	var pads = gamepad_get_device_count();
	show_debug_message(string(pads) + " pads detected");
	// Loop throug all pads
	for (var i = 0; i < pads; i++) {
	    if (gamepad_is_connected(i)) {
			show_debug_message("connected: " + string(i));
			// Loop through all of this pad's buttons
			for(var j = 0; j < gamepad_button_count(i); j++) {
				if(gamepad_button_check(i, j)) {
					show_debug_message("pad #" + string(i) + " detected");
					padDevice = i;
					return padDevice;
				}
			}
	    }
	}
	
	// no pad found
	return noone;
}

// -----------------------------
// Check for a given button in gamepad, and set device if needed
// -----------------------------
function inputPad(button) {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	return gamepad_button_check(device, button);
	
}

function inputPadPressed(button) {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	return gamepad_button_check_pressed(device, button);
	
}

function inputPadReleased(button) {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	return gamepad_button_check_released(device, button);
}

// Directions
function inputPadDown() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	return gamepad_axis_value(device, gp_axislv) > 0;
}

function inputPadUp() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	var device = getPadDevice();
	return gamepad_axis_value(device, gp_axislv) < 0;
}

function inputPadLeft() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	var device = getPadDevice();
	return gamepad_axis_value(device, gp_axislh) < 0;
}

function inputPadRight() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	var device = getPadDevice();
	return gamepad_axis_value(device, gp_axislh) > 0;
}

// -----------------------------
// Check for any button in gamepad
// -----------------------------
// NB: inputPad(), inputPadReleased() and inputPadPressed() not used here
// because we need to get the device first, in order to loop through all buttons
function inputPadAny() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	
	for(var i = 0; i < gamepad_button_count(device); i++) {
		if(gamepad_button_check(device, i)) {
			return true;
		}
	}
	return false;
}

function inputPadAnyReleased() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	for(var i = 0; i < gamepad_button_count(device); i++) {
		if(gamepad_button_check_released(device, i)) {
			return true;
		}
	}
	return false;
}

function inputPadAnyPressed() {
	var device = getPadDevice();
	if(device == noone) {
		return false;
	}
	for(var i = 0; i < gamepad_button_count(device); i++) {
		if(gamepad_button_check_pressed(device, i)) {
			return true;
		}
	}
	return false;
}


// -----------------------------
// Check for any key / button
// -----------------------------
function inputAny() {
	return keyboard_check(vk_anykey) || inputPadAny();
}

function inputAnyReleased() {
	return keyboard_check_released(vk_anykey) || inputPadAnyReleased();
}

function inputAnyPressed() {
	return keyboard_check_pressed(vk_anykey) || inputPadAnyPressed();
}

// -----------------------------
// Check for given key / button
// -----------------------------
// Directions
function inputDown() {
	return keyboard_check(KEY_DOWN) || inputPadDown();
}

function inputUp() {
	return keyboard_check(KEY_UP) || inputPadUp();
}

function inputLeft() {
	return keyboard_check(KEY_LEFT) || inputPadLeft();
}

function inputRight() {
	return keyboard_check(KEY_RIGHT) || inputPadRight();
}

// Jump
function inputJump() {	
	return keyboard_check(KEY_JUMP) || inputPad(PAD_JUMP);
}

function inputJumpReleased() {
	return keyboard_check_released(KEY_JUMP) || inputPadReleased(PAD_JUMP);
}

function inputJumpPressed() {
	return keyboard_check_pressed(KEY_JUMP) || inputPadPressed(PAD_JUMP);
}

// Duck
function inputDuck() {
	return keyboard_check(KEY_DUCK) || inputPadDown();
}

// Grind
function inputGrind() {
	return keyboard_check(KEY_GRIND) || inputPad(PAD_GRIND);
}

function inputGrindReleased() {
	return keyboard_check_released(KEY_GRIND) || inputPadReleased(PAD_GRIND);
}

function inputGrindPressed() {
	return keyboard_check_pressed(KEY_GRIND) || inputPadPressed(PAD_GRIND);
}


