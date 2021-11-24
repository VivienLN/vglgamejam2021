if(isGliding) {
	sprite_index = sCharacterGliding;
} else if(isBigJump) {
	sprite_index = sCharacterTrick;
} else if(isFalling) {
	if(ySpeed >= 0) {
		sprite_index = sCharacterFalling;
	} else {
		sprite_index = sCharacterJumping;
	}
} else if(isDucking || isGrinding) {
	sprite_index = sCharacterDucking;
} else {
	sprite_index = sCharacter;
}