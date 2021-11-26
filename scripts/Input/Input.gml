// -----------------------------
// Check for any button in gamepad
// -----------------------------
function inputPadAny() {
	for(var i = 0; i < gamepad_button_count(PAD_DEVICE); i++) {
		if(gamepad_button_check(PAD_DEVICE, i)) {
			return true;
		}
	}
	return false;
}

function inputPadAnyReleased() {
	for(var i = 0; i < gamepad_button_count(PAD_DEVICE); i++) {
		if(gamepad_button_check_released(PAD_DEVICE, i)) {
			return true;
		}
	}
	return false;
}

function inputPadAnyPressed() {
	for(var i = 0; i < gamepad_button_count(PAD_DEVICE); i++) {
		if(gamepad_button_check_pressed(PAD_DEVICE, i)) {
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
// Jump
function inputJump() {
	return keyboard_check(KEY_JUMP) || gamepad_button_check(PAD_DEVICE, PAD_JUMP);
}

function inputJumpReleased() {
	return keyboard_check_released(KEY_JUMP) || gamepad_button_check_released(PAD_DEVICE, PAD_JUMP);
}

function inputJumpPressed() {
	return keyboard_check_pressed(KEY_JUMP) || gamepad_button_check_pressed(PAD_DEVICE, PAD_JUMP);
}

// Duck
function inputDuck() {
	return keyboard_check(KEY_DUCK) || gamepad_axis_value(PAD_DEVICE, gp_axislv) > 0;
}

// Grind
function inputGrind() {
	return keyboard_check(KEY_GRIND) || gamepad_button_check(PAD_DEVICE, PAD_GRIND);
}

function inputGrindReleased() {
	return keyboard_check_released(KEY_GRIND) || gamepad_button_check_released(PAD_DEVICE, PAD_GRIND);
}

function inputGrindPressed() {
	return keyboard_check_pressed(KEY_GRIND) || gamepad_button_check_pressed(PAD_DEVICE, PAD_GRIND);
}

// Directions
function inputDown() {
	return gamepad_axis_value(PAD_DEVICE, gp_axislv) > 0;
}

function inputUp() {
	return gamepad_axis_value(PAD_DEVICE, gp_axislv) < 0;
}

function inputLeft() {
	return gamepad_axis_value(PAD_DEVICE, gp_axislh) < 0;
}

function inputRight() {
	return gamepad_axis_value(PAD_DEVICE, gp_axislh) > 0;
}
